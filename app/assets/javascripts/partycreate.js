document.addEventListener('DOMContentLoaded', function(){
    getAvailableDevices();
}, false);

async function getAvailableDevices() {
  const url = '/api/v1/me/available_devices';

  fetch(url)
    .then(function(response) {
      return response.json();
    })
    .then(function(devices) {
      documentTarget = document.getElementById('device-list');
      documentTarget.innerHTML = "";
      for (var i = 0; i < devices.data.length; i++) {
        let currentDevice = devices.data[i].attributes;
        newSelect = document.createElement('OPTION');
        newSelect.setAttribute('value', currentDevice.id);
        newSelect.innerHTML = currentDevice.name;
        documentTarget.appendChild(newSelect);
      }
    });
}
