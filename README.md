# Audio

PulseAudio implementation for Home Assistant.

This container ships the upstream ALSA configs and base settings for PulseAudio.

## How it works

The central audio container handles the ALSA settings and runs a PulseAudio service on top.
The PulseAudio service is exposed to Home Assistant and Add-ons if they need audio support.

This way of implementing audio support allows us to manage all audio related configuration in one place.
By decoupling audio handling from Supervisor and HAOS, we can instead give full control over the audio to the user.
Users can load and modify PulseAudio modules according to their use cases, while the Supervisor just manages the container itself.

## Troubleshooting

Troubleshooting requires CLI access, which can be achieved with the Terminal Add-ons from Core or Community.
Most useful for troubleshooting are the Home Assistant CLI `ha audio` commands, as well as the ability to control PulseAudio directly via `pactl`.

### Container

The audio container can be managed through the Home Assistant CLI:

| Command            | Description                                             |
| ------------------ | ------------------------------------------------------- |
| `ha audio default` | Set default input/output audio device.                  |
| `ha audio info`    | Provides information about Home Assistant Audio devices |
| `ha audio logs`    | View the log output of Home Assistant Audio             |
| `ha audio profile` | Set the Home Assistant Audio profile for a card         |
| `ha audio reload`  | Reload the Home Assistant Audio updating information    |
| `ha audio restart` | Restarts the internal Home Assistant Audio container    |
| `ha audio stats`   | Provides system usage stats of Home Assistant Audio     |
| `ha audio update`  | Update the Home Assistant Audio container               |
| `ha audio volume`  | Audio device volume control.                            |

### PulseAudio

You have full access to the Pulse server to adjust any kind of settings. A full list of settings is available with:

`pactl list`

This is useful mostly if you have sound issues, and need to enable a different profile for your card.
