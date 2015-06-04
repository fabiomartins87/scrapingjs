_ = require 'lodash'
assert = require "assert"

scrapingjs = require('../')

describe 'crawling test', ->
  instance = null

  @timeout(10000)

  it 'crawls http://www.yahoo.co.jp/', ->
    row = yield scrapingjs.scrape("http://www.yahoo.co.jp")

    assert.equal row.title, 'Yahoo! JAPAN'
    assert.ok !!row.description
    assert.ok !!row.thumbnail_url
    assert.ok !!row.sitename
    assert.equal row.url, "http://www.yahoo.co.jp/"

    return

  it 'crawls youtube.com video', ->
    row = yield scrapingjs.scrape("http://www.youtube.com/watch?v=tuK6n2Lkza0&test=1")

    assert.equal row.title, 'Jet - Are You Gonna Be My Girl - YouTube'
    assert.ok !!row.description
    assert.ok !!row.thumbnail_url
    assert.ok !!row.sitename
    assert.equal row.url, "https://www.youtube.com/watch?v=tuK6n2Lkza0&test=1"

    return

  # NON UTF-8 Page (EUC-JP) Crawling
  it 'crawls http://www.goo-net.com/usedcar/', ->
    row = yield scrapingjs.scrape("http://www.goo-net.com/usedcar/")

    assert.equal row.title, '中古車情報 | 中古車検索ならGoo-net(グーネット)'
    assert.ok !!row.description
    assert.ok !!row.thumbnail_url
    assert.ok !!row.sitename
    assert.equal row.url, "http://www.goo-net.com/usedcar/"

    return
