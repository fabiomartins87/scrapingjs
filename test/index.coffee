_ = require 'lodash'
assert = require "assert"

scrapingjs = require('../')

describe 'crawling test', ->
  instance = null

  it 'crawls http://www.yahoo.co.jp/', ->
    row = yield scrapingjs.scrape("http://www.yahoo.co.jp")

    assert.equal row.title, 'Yahoo! JAPAN'
    assert.ok !!row.description
    assert.ok !!row.thumbnail_url
    assert.ok !!row.sitename
    assert.ok !!row.url

    return

  it 'crawls youtube.com video', ->
    row = yield scrapingjs.scrape("https://www.youtube.com/watch?v=tuK6n2Lkza0")

    console.log row

    assert.equal row.title, 'Jet - Are You Gonna Be My Girl - YouTube'
    assert.ok !!row.description
    assert.ok !!row.thumbnail_url
    assert.ok !!row.sitename
    assert.ok !!row.url

    return
