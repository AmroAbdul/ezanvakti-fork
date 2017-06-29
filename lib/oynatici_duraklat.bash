#
#
#                           Ezanvakti Oynatıcı Duraklatma Bileşeni 1.6
#
#

function qdbus_sorgu() {
  local komut

  komut=$(qdbus org.mpris.MediaPlayer2.$1 /org/mpris/MediaPlayer2 \
            org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus)

  if [[ ${komut} = Playing ]]
  then
      return 0
  else
      return 1
  fi
}

function dbus_sorgu() {
  local komut

  komut=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.$1\
        /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' \
        string:'PlaybackStatus' | awk -F'[\"]' '/string/ {print $2;}')

  if [[ ${komut} = Playing ]]
  then
      return 0
  else
      return 1
  fi
}


function oynatici_islem() {
  local -a OYNATICILAR DURDURULAN
  local oynatici

  OYNATICILAR=( spotify deadbeef clementine amarok rhythmbox
                aqualung audacious banshee exaile cmus
                moc qmmp juk)

  for oynatici in ${OYNATICILAR[@]}
  do
    [[ -n $(pgrep ${oynatici}) ]] && {
      if [[ ${oynatici} = spotify ]]
      then
          if dbus_sorgu spotify;
          then
              dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
              /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1
              DURDURULAN+=('spotify')
          fi

      elif [[ ${oynatici} = deadbeef ]]
      then
          deadbeef --pause > /dev/null 2>&1
          DURDURULAN+=('deadbeef')

      elif [[ ${oynatici} = clementine ]]
      then
          if qdbus_sorgu clementine;
          then
              clementine --pause > /dev/null 2>&1
              DURDURULAN+=('clementine')
          fi

      elif [[ ${oynatici} = amarok ]]
      then
          if qdbus_sorgu amarok;
          then
              amarok --pause  > /dev/null 2>&1
              DURDURULAN+=('amarok')
          fi

      elif [[ ${oynatici} = rhythmbox ]]
      then
          rhythmbox-client --pause  > /dev/null 2>&1
          DURDURULAN+=('rhytmbox')

      elif [[ ${oynatici} = aqulung ]]
      then
          aqualung --pause > /dev/null 2>&1
          DURDURULAN+=('aqualung')

      elif [[ ${oynatici} = audacious ]]
      then
          if dbus_sorgu audacious;
          then
              audacious --pause > /dev/null 2>&1
              DURDURULAN+=('audacious')
          fi

      elif [[ ${oynatici} = banshee ]]
      then
          banshee --pause > /dev/null 2>&1
          DURDURULAN+=('banshee')

      elif [[ ${oynatici} = exaile ]]
      then
          exaile --play-pause > /dev/null 2>&1
          DURDURULAN+=('exaile')

      elif [[ ${oynatici} = moc ]]
      then
          moc --pause > /dev/null 2>&1
          DURDURULAN+=('moc')

      elif [[ ${oynatici} = cmus ]]
      then
          if [[ $(cmus-remote -C status | head -1) = status\ playing ]]
          then
              cmus-remote --pause > /dev/null 2>&1
              DURDURULAN+=('cmus')
          fi

      elif [[ ${oynatici} = qmmp ]]
      then
          if qdbus_sorgu qmmp;
          then
              qmmp --pause > /dev/null 2>&1
              DURDURULAN+=('qmmp')
          fi

      elif [[ ${oynatici} = juk ]]
      then
          if qdbus_sorgu juk;
          then
              qdbus org.kde.juk /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
              DURDURULAN+=('juk')
          fi
      fi
    }
  done

################################################################
 mplayer_calistir "${vakit_ezani}"                             #
(( EZAN_DUASI_OKU )) && mplayer_calistir "${EZAN_DUASI}"       #
################################################################

  for oynatici in ${DURDURULAN[@]}
  do
      if [[ ${oynatici} = spotify ]]
      then
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
                    /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1

      elif [[ ${oynatici} = deadbeef ]]
      then
          deadbeef --play > /dev/null 2>&1

      elif [[ ${oynatici} = clementine ]]
      then
          clementine --play > /dev/null 2>&1

      elif [[ ${oynatici} = amarok ]]
      then
          amarok --play > /dev/null 2>&1

      elif [[ ${oynatici} = rhythmbox ]]
      then
          rhythmbox-client --play > /dev/null 2>&1

      elif [[ ${oynatici} = aqulung ]]
      then
          aqualung --play > /dev/null 2>&1

      elif [[ ${oynatici} = audacious ]]
      then
          audacious --play > /dev/null 2>&1

      elif [[ ${oynatici} = banshee ]]
      then
          banshee --play > /dev/null 2>&1

      elif [[ ${oynatici} = exaile ]]
      then
          exaile --play-pause > /dev/null 2>&1

      elif [[ ${oynatici} = moc ]]
      then
          moc --play > /dev/null 2>&1

      elif [[ ${oynatici} = cmus ]]
      then
          cmus-remote --play > /dev/null 2>&1

      elif [[ ${oynatici} = qmmp ]]
      then
          qmmp --play > /dev/null 2>&1

      elif [[ ${oynatici} = juk ]]
      then
          qdbus org.kde.juk /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
      fi

  done
}

# vim: set ft=sh ts=2 sw=2 et:
