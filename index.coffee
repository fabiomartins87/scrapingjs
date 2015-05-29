'use strict';

cheerio = require('cheerio')
request = require('koa-request')

fetch = (url) ->
  options =
    url: url,
    headers: { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36 scrapingjs(0.0.1)' }
  yield request(options)

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

parseImage = ($, uri) ->
  ogimage = $('meta[property="og:image"]').attr('content')

  ogimage

parseSitename = ($) ->
  sitename = $('meta[property="og:site_name"]').attr('content')

  #TODO: Make upper case of domain main area???

  sitename

module.exports.scrape = (url) ->
  response = yield fetch(url)
  $ = cheerio.load(response.body)

  #TODO: url normalization???

  res =
    title: parseTitle($)
    description: parseDescription($)
    thumbnail_url: parseImage($, response.request.uri)
    sitename: parseSitename($)
    url: response.request.uri.href
  return res
