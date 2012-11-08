{browserAction, windows, tabs} = chrome

delay = 300  # ms

timeoutID = null
flag = false


reloadTabs = ($tabs) ->
    tabs.reload item.id for item in $tabs


onClick = ($double) ->

    windows.getCurrent populate: true, ($window) ->

        pinnedList = (item for item in $window.tabs when item.pinned)
        unpinnedList = $window.tabs[pinnedList.length..]

        if pinnedList.length
            reloadTabs if $double then unpinnedList else pinnedList
        else
            reloadTabs unpinnedList


browserAction.onClicked.addListener ->

    onClick true if flag

    clearTimeout timeoutID

    timeoutID = setTimeout ($double) ->
        onClick false unless $double
        flag = false
    , delay, flag

    flag = true
