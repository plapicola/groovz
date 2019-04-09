document.addEventListener('DOMContentLoaded', function() {
  queryCurrentTrack();
  subcribeToChannel();
}, false);

function queryCurrentTrack() {
  const currentTrackUrl = '/api/v1/me/currently_playing';
  fetch(currentTrackUrl)
  .then(function(response) {
    return response.json();
  })
  .then(function(currentTrack) {
    if (currentTrack.data !== null)
    updateTrackInfo(current_track);
  })
}

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
