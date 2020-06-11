using Profile
using Random
using HTTP
using Cascadia
using Gumbo

# This is a sample crawler which crawls news data from TasnimNews Agency.

function fetch_urls(tag, date)
    base_url = "https://www.tasnimnews.com"
    url_params = "$base_url/fa/archive?service=$tag&sub=-1&date=$date"
    res = HTTP.request("GET", url_params)
    data = parsehtml(String(res.body))
    selector = Selector(".archive-result .content a")
    news_links = eachmatch(selector, data.root)
    links = []
    if size(news_links)[1] != 0 # Avoiding no news loop/errors with the given params
        for item in news_links
            push!(links, base_url * attrs(item)["href"])
        end
    end
    return links
end

function fetch_data(url)
    res = HTTP.request("GET", url)
    data = parsehtml(String(res.body))
    title_slc = Selector("h1.title")
    lead_slc = Selector("h3.lead")
    story_slc = Selector(".story")
    title = nodeText(eachmatch(title_slc, data.root)[1])
    spam = findfirst("صدای تسنیم", title)
    if spam != nothing
        return
    end
    lead = nodeText(eachmatch(lead_slc, data.root)[1])
    story = eachmatch(story_slc, data.root)
    story_part_slc = Selector("p")
    story_parts = map(item -> eachmatch(Selector("p"), item), story)
    full_news = ""
    println("fetching $title")
    for item in story_parts
        for part in item
            full_news *= " " * nodeText(eachmatch(Selector("p"), part)[1])
        end
    end
    title*",", lead*",", full_news

end

function fetch_news(t, d)
    # fectched_news = Dict()
    fectched_news = []
    y, m, d = d
    tag = t
    @time for i in y
        for j in m
            for k in d
                push!(fectched_news, map(url -> fetch_data(url), fetch_urls(tag, "$i%2F$j%2F$k")))
            end
        end
    end
    return fectched_news
end

function save_news(t, d, f_name)
    news_data = fetch_news(t, d)
    f = "$f_name.txt"
    count = 0
    open(f, "w") do file
        for day_news in news_data
            for news in day_news
                count = count+1
                if news != nothing
                    map(j -> write(file, j), news) # Write title, lead and story
                    write(file, "\n")
                end
            end
        end
        println("Finished! Wrote $count news to $f_name.txt")
    end
end

# Tags guide: politics("1"), sports("3"), culture("4"), economics("7")
tags = ["1", "3", "4", "7"]
date = (1399, 3, 1)
file_name = ["politics", "sports", "culture", "economics"]
save_news(tags[1], date, file_name[1])
