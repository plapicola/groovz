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
      showPlaybackControls();
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
        updateTrackInfo(data);
        userSavedTrack(data);
        console.log(data);
    }
  });
}

function updateTrackInfo(data){
  let trackInfo = data.message.data.attributes;
  document.getElementById("album-art").src = trackInfo.img_url;
  document.getElementById("track-title").innerHTML = trackInfo.title;
  document.getElementById("track-artist").innerHTML = trackInfo.artist;
}

function userSavedTrack(data) {
  let trackId = data.message.data.attributes.spotify_id
  const trackStatusUrl = `api/v1/me/track_status?id=${trackId}`;
  fetch(trackStatusUrl)
  .then(function(response){
    return response.json();
  })
  .then(function(trackStatus){
    let track = trackStatus.data.attributes;
    console.log(track.id)
    renderSaveButton(track.id, track.status);
  })
}

function renderSaveButton(trackId, type){
  console.log(type)
  let target = document.getElementById("save-track");
  if (type === false) {
    target.src = "plus_template.png";
    target.onclick = function() {
      event.preventDefault();
      saveOrRemoveTrack(trackId, type)
    };
  }
  else if (type === true) {
    target.src = "check-mark-template.png";
    target.onclick = function(){
      event.preventDefault();
      saveOrRemoveTrack(trackId, type);
    };
  }
}

function saveOrRemoveTrack(trackId, type) {
  const saveUrl = `api/v1/me/save_track?id=${trackId}&type=${type}`;
  console.log(saveUrl)
  fetch(saveUrl)
  .then(function(response) {
    return response.json();
  })
  .then(function(message){
    console.log(message.data.attributes.status);
  });
  if (type === true) {
  renderSaveButton(trackId, false)
  }
  else if (type === false){
    renderSaveButton(trackId, true)
  };
}
