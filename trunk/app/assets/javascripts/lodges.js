$(document).ready(function() {
    // let the gallery items be draggable
        $(".attendee-container > li").draggable({
            revert: "invalid", // when not dropped, the item will revert back to its initial position
            containment: $( "#demo-frame" ).length ? "#demo-frame" : "document", // stick to demo-frame if present
            helper: "clone",
            cursor: "move"
        });

        // let the trash be droppable, accepting the gallery items
        $(".attendee-container").droppable({
            accept: ".attendee-container > li",
            activeClass: "ui-state-highlight",
            drop: function( event, ui ) {
                var targetId = $(this).attr("id");
                move(targetId, ui.draggable);
            }
        });

        function move($targetId, $item)
        {
            $item.fadeOut(function() {
                $item.appendTo("#" + $targetId).fadeIn();
            });
        }
});