# Audio

PulseAudio implementation for Home Assistant.

This container ship the upstream ALSA configs and base settings for Pulse.

## How it works

We have a central container they handle the ALSA settings and run on top a PulseAudio service. They service is expose to Home Assistant and Add-ons if they need audio support. This handling allow us to manage all central on one place and streamline the audio as a plaform.

The second benefit if that is give the control over the audio to the user. He can load and modify Pulse module and adjust his use case without need changes on Supervisor or Operating-System.

The Supervisor just manage the container and distribute updates and is responsible for management of this container.

## Troubleshooting

You can make troubleshooting with the Terminal Add-ons from Core or Community. The are 2 Layers for troubleshooting: The container and the PulseAudio server.

### Container

With Home Assistant cli util `ha` you can manage the container and there output:

| Command  | Description   |
|----------|---------------|
| ha audio info | Show all information they are available on Supervisor |
| ha audio reload | Reload information from running Pulse server |
| ha audio logs | Show output of Pulse server. |
| ha audio restart | Restart the PulseAudio container. |

### PulseAudio

You have the full access to the Pulse server to adjust any kind of settings and optimize. A full list of loaded settings is available with:

`pactl list`

Mostly you have sound issues and need enable a different Profile for you Card.

