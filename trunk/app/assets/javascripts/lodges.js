$(document).ready(function() {

    //let the items be draggable
    $(".attendee-container > li").draggable({
        revert: "invalid", // when not dropped, the item will revert back to its initial position
        containment: "document",
        helper: "clone",
        cursor: "move"
    });

    //let all containers be droppable
    $(".attendee-container").droppable({
        accept: ".attendee-container > li",
        activeClass: "ui-state-highlight",
        drop: function(event, ui) {
            var targetId = $(this).attr('id');

            if(ui.draggable.parent().attr('id') != targetId)
                move(targetId, ui.draggable);
        }
    });

    function move($targetId, $item)
    {
        var url = $(location).attr('href');
        
        if($targetId == 'lodgeless-attendees')
            url = url + '/0/remove_attendee'; //fix url?
        else
            url = url + '/' + $targetId + '/add_attendee';

        $.ajax({
            url: url,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify({'registration_id': $item.attr('id')}),
            dataType: 'json'
        }).done(function(data) {
            $item.fadeOut(function() {
                $item.appendTo("#" + $targetId).fadeIn();
            });
        });
    }
});