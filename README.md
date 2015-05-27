# ScrapingJS

ScrapingJS is very simple scraper which fetch TITLE, DESCRIPTION and THUMBNAIL from website!

ScrapingJS use title tag, meta description and OGPs to fetch information.
We aim to fetch many website with simple API without any problems.

## Installation

    npm install scrapingjs


## Getting started

You simply require code and fetch titles!

    scrapingjs = require('scrapingjs')

    data = yield scrapingjs.scrape('http://www.yahoo.com/')

    # you can fetch data.title, data.description, data.thumbnail_url and data.sitename
    console.log(data)

## LICENSE

MIT

## Author

Shota Watanabe <shota.w@gmail.com>
