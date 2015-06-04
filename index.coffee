'use strict';

client = require('cheerio-httpcli')

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
  result = yield client.fetch(url, {})

  $ = result.$

  res =
    title: parseTitle($)
    description: parseDescription($)
    thumbnail_url: parseImage($, result.response.request.uri)
    sitename: parseSitename($)
    url: result.response.request.uri.href
  return res
