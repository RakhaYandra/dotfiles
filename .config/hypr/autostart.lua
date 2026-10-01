-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- ActivityWatch: tracking pemakaian (dashboard localhost:5600)
o.exec_on_start("aw-qt >/dev/null 2>&1 &")
-- Guard media: cegah idle saat ada video/audio Playing (MPRIS)
o.exec_on_start("pgrep -f '[o]marchy-media-stay-awake' >/dev/null || omarchy-media-stay-awake >/dev/null 2>&1 &")
-- EasyEffects: speaker clarity chain (LoudnessEqualizer) tiap login
o.exec_on_start("(pgrep -x easyeffects >/dev/null || easyeffects --service-mode -l LoudnessEqualizer -w >/dev/null 2>&1 &) ; for i in $(seq 1 20); do pactl list sinks short 2>/dev/null | grep -q easyeffects_sink && break; sleep 0.5; done; pactl set-default-sink easyeffects_sink >/dev/null 2>&1 &")
-- Mic amankan tiap login (ALSA reset pas reboot/reinstall kalau lupa alsactl store)
o.exec_on_start("amixer -c2 set Capture 70% >/dev/null && amixer -c2 set 'Internal Mic Boost' 33% >/dev/null && wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.27")
-- Hyousee island (v0.4.0-fase45, dev binary; ganti ke /usr/bin/hyousee setelah pack).
o.exec_on_start("pgrep -f '[t]arget/debug/hyousee' >/dev/null || /home/rakha/Work/hyousee/hyousee/linux/src-tauri/target/debug/hyousee >/dev/null 2>&1 &")
