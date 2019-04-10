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
    if (currentTrack.data !== null) {
      updateTrackInfo(currentTrack);
    }
  })
}

function startPlayback() {
  const startPlaybackUrl = '/api/v1/me/start_playback';
  fetch(startPlaybackUrl, {
    method: "PUT"
  })
  .then(function(response) {
    console.log(response);
    if (response.status === 200) { // Expect no body
      showPlaybackControls();
    }
  })
  .catch(function(error) {
    let playbackText = document.getElementsByClassName('track-info')[0];
    playbackText.getElementsByTagName('p').innerHTML = 'Something went wrong. Please try again.';
  })
}

function showPlaybackControls() {
  let startButton = document.getElementById('start-party-button');
  let playerControls = document.getElementById('player-controls');
  startButton.classList.add('hide');
  playerControls.classList.remove('hide');
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
