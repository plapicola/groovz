document.addEventListener('DOMContentLoaded', function() {
  subcribeToChannel();
}, false);

function subcribeToChannel() {
  App.messages = App.cable.subscriptions.create( {
    channel: 'PartiesChannel', room: `parties-${roomCode}`},
    {
      received: function(data) {
        console.log(data);
        $("#messages").removeClass('hidden')
        return $("[data-chatroom='" + data.chatroom_id + "']").append(data.message);
    }
  });
}
