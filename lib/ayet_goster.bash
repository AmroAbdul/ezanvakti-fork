#
#
#
#
#

function ayet_goster() { # {{{
   [ -f "${KULLANICI_TEFSIR_DIZINI}/${TEFSIR_SAHIBI}" ] && {
      TEFSIR="${KULLANICI_TEFSIR_DIZINI}/${TEFSIR_SAHIBI}"
    } || {
    [ -f "${VERI_DIZINI}/tefsirler/${TEFSIR_SAHIBI}" ] && \
      TEFSIR="${VERI_DIZINI}/tefsirler/${TEFSIR_SAHIBI}"
    } || {
      printf "${RENK3}${TEFSIR_SAHIBI} dosyası bulunamadı.${RENK0}\n"
      exit 1
    }

    satir=$((RANDOM%6236))
    (( ! satir )) && satir=6236

    case $1 in
      ucbirim)
        printf '%b%b%b\n' \
          "${RENK3}\nGünlük Ayet ${RENK2}(${RENK8}" \
          "$(sed -n "${satir}p" ${VERI_DIZINI}/veriler/sureler_ayetler) $satir/6236${RENK2})${RENK8}\n\n" \
          "$(sed -n "${satir}p" "${TEFSIR}")${RENK0}"
        exit 0 ;; 
     bildirim)
       notify-send "Günlük Ayet ($(sed -n "${satir}p" ${VERI_DIZINI}/veriler/sureler_ayetler))" \
        "$(sed -n "${satir}p" "${TEFSIR}")" -t $AYET_BILDIRIM_SURESI"000" -h int:transient:1
       exit 0 ;;
    esac  
} # }}}

# vim: set ft=sh ts=2 sw=2 et: