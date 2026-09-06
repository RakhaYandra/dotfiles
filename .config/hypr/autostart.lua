-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Mic amankan tiap login (ALSA reset pas reboot/reinstall kalau lupa alsactl store)
o.exec_on_start("amixer -c2 set Capture 70% >/dev/null && amixer -c2 set 'Internal Mic Boost' 33% >/dev/null && wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.27")
