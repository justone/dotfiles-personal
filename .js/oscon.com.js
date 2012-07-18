var highlighting_chosen_sessions = false;
function highlight_chosen_sessions() {

    // look for all hightlighted icons and update the session div to have a border
    $('img[src="/images/personal-schedule-icon2.png"]').each(function(index, icon) {
        $(icon)
            .closest('.session')
            .not('.highlighted')
            .addClass('highlighted')
            .css({ 'border': '3px solid black' }).each(function(idx, session) {
                $(session).css({ height: $(session).height() - 6 , width: $(session).width() - 6  });
            });
    });

    // look for any sessions that are no longer selected and remove the border
    $('div.highlighted').each(function(index, session) {
        if ($('img[src="/images/personal-schedule-icon.png"]', session).length > 0) {
            $(session)
                .removeClass('highlighted')
                .removeAttr('style');
        }
    });
}

highlight_chosen_sessions();

// detect changes and reload
$(document).delegate('body',"DOMSubtreeModified", function(e) {
    // re-add the links, but only if this event isn't part of adding the links
    if (!highlighting_chosen_sessions) {
        highlight_chosen_sessions();
    }
});
