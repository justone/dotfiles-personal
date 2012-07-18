var highlighting_chosen_sessions = false;
var hidden = false;
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

function toggleSessions() {
    if (hidden) {
        $('.session')
            .not('.highlighted')
            .show();
        hidden = false;
    } else {
        $('.session')
            .not('.highlighted')
            .hide();
        hidden = true;
    }
}

$('#en_grid_dates ul')
    .append(
        $('<li>')
            .append(
                $('<a>')
                    .attr('href', '')
                    .text('show/hide my sessions')
                    .click(function(e) {
                        e.preventDefault();
                        toggleSessions();
                    })
            )
    );

function hideSession(session) {
    $(session).hide();
}

// add an 'x' to each session to help eliminate ones that you don't want to attend
$('div.session').each(function(index, session) {
    $(document.createElement('p'))
    .css({
        display:'block', position:'absolute', bottom:'0', right:'0', margin: '0', padding: '4'
    })
    .append($(document.createElement('a'))
        .attr({
            'href': '#'
        })
        .text('x')
        .click(function(e) {
            e.preventDefault();
            hideSession(session);
            return false;
        })
    )
    .appendTo(session)
    ;
});
