+++
Title = "Mozilla Firefox"
weight = 1
+++

## Remove AI overview and other junk from Google search results

While it's great to just say "switch to DuckDuckGo", Google sadly provides the
best results and in my experience, enables you to be much more productive in your
searches.

### Android

Navigate to Settings -> Search -> Default search engine

Click "Add search engine"

Input the following values:

- Name: Google UDM14
- Search string URL: https://google.com/search?q=%s&udm=14
- Search suggestions API URL: https://suggestqueries.google.com/complete/search?client=firefox&q=%s

### Desktop

1. Go to `about:config`

2. Add `browser.urlbar.update2.engineAliasRefresh` (if it does not exist) with value `true`

3. Reload Firefox

4. Navigate to Settings -> Search

5. Click "Add" underneath the "Search Shortcuts" table

6. Input the following values:

    - Search engine name: Google UDM14
    - Engine URL: https://google.com/search?q=%s&udm=14
    - Alias: @udm14

7. Update the "Default Search Engine" setting at the top

Alternatively, you can use this extension https://addons.mozilla.org/en-US/firefox/addon/udm14/
but I try to keep the number of extensions I install down to a minimum.
