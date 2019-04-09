document.addEventListener('DOMContentLoaded', function() {
  queryCurrentTrack();
  subcribeToChannel();
}, false);

function queryCurrentTrack() {
  const currentTrackUrl = '/api/v1/me/currently_playing';
  fetch(currentTrackUrl)
  .then(function(response) {
    console.log(response);
    return response.json();
  })
  .then(function(current_track) {
    console.log(current_track);
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
