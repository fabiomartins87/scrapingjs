'use strict';

cheerio = require('cheerio')
request = require('koa-request')

fetch = (url) ->
  options =
    url: url,
    headers: { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36 scrapingjs(0.0.1)' }
  response = yield request(options)
  return response.body

parseTitle = ($) ->
  # first grabbing title tag, after that choose first h1
  title = $('title').text()
  unless title
    title = $('h1').eq(0).text()
  title

parseDescription = ($) ->
  # first grabbing meta-description, 2nd og:description, 3rd body text
  description = $('meta[name="description"]').attr('content')
  unless description
    description = $('meta[property="og:description"]').attr('content')
  description

parseImage = ($) ->
  ogimage = $('meta[property="og:image"]').attr('content')
  unless ogimage
    ogimage = $('img').eq(0).attr('src')
  ogimage

parseSitename = ($) ->
  sitename = $('meta[property="og:site_name"]').attr('content')

  #TODO: Make upper case of domain main area???

  sitename

module.exports.scrape = (url) ->
  html = yield fetch(url)
  $ = cheerio.load(html)

  #TODO: url normalization???

  res =
    title: parseTitle($)
    description: parseDescription($)
    thumbnail_url: parseImage($)
    sitename: parseSitename($)
    url: url
  return res
