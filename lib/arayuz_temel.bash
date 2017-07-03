#
#
#
#
#

if ! [[ -x $(type -p yad) ]]
then
    printf "Bu özellik YAD gerektirmektedir...\n" >&2
    exit 1
fi

sure_listesi='!1-Fatiha!2-Bakara!3-Al-i İmran!4-Nisa!5-Maide!6-Enam!7-Araf!8-Enfal!9-Tevbe!10-Yunus'
sure_listesi+='!11-Hud!12-Yusuf!13-Rad!14-İbrahim!15-Hicr!16-Nahl!17-İsra!18-Kehf!19-Meryem!20-Taha'
sure_listesi+='!21-Enbiya!22-Hac!23-Müminun!24-Nur!25-Furkan!26-Şuara!27-Neml!28-Kasas!29-Ankebut'
sure_listesi+='!30-Rum!31-Lokman!32-Secde!33-Ahzab!34-Sebe!35-Fatır!36-Yasin!37-Saffat!38-Sad'
sure_listesi+='!39-Zümer!40-Mümin!41-Fussilet!42-Şura!43-Zuhruf!44-Duhan!45-Casiye!46-Akaf'
sure_listesi+='!47-Muhammed!48-Fetih!49-Hucurat!50-Kaf!51-Zariyat!52-Tur!53-Necm!54-Kamer'
sure_listesi+='!55-Rahman!56-Vakia!57-Hadid!58-Mücadele!59-Haşr!60-Mümtehine!61-Saf!62-Cuma'
sure_listesi+='!63-Münafikun!64-Tegabun!65-Talak!66-Tahrim!67-Mülk!68-Kalem!69-Hakka!70-Mearic'
sure_listesi+='!71-Nuh!72-Cin!73-Müzzemmil!74-Müddessir!75-Kıyame!76-İnsan!77-Mürselat!78-Nebe'
sure_listesi+='!79-Naziat!80-Abese!81-Tekvir!82-İnfitar!83-Mutaffifın!84-İnşikak!85-Büruc'
sure_listesi+='!86-Tarık!87-Ala!88-Gaşiye!89-Fecr!90-Beled!91-Şems!92-Leyl!93-Duha!94-İnşirah'
sure_listesi+='!95-Tin!96-Alak!97-Kadir!98-Beyyine!99-Zilzal!100-Adiyat!101-Karia!102-Tekasür'
sure_listesi+='!103-Asr!104-Hümeze!105-Fil!106-Kureyş!107-Maun!108-Kevser!109-Kafirun!110-Nasr'
sure_listesi+='!111-Tebbet!112-İhlas!113-Felak!114-Nas'

tamamlama_listesi='!Ayarlar!Ayet!Sabah!Öğle!İkindi!Akşam!Yatsı!yapilandirma!Hadis!Esma-ül Hüsna'
tamamlama_listesi+='!Bilgi!Aylık Vakitler!Haftalık Vakitler!Dini Günler ve Geceler!hakkında'
tamamlama_listesi+="!about!güncelle!yardım!arayuz2!Kerahat!000!özel pencere!$sure_listesi"

secim_listesi='!Haftalık Vakitler!Aylık Vakitler!Kerahat Vakitleri!Dini Günler ve Geceler'
secim_listesi+='!Ayet!Hadis!Bilgi!Esma-ül Hüsna!Yapılandırma Yöneticisi'

# düz komut çıktıları için rengi sıfırla.
export RENK_KULLAN=0 RENK=0

function arayuz_pid_denetle() {
  local ypid=$$

  if [[ -f /tmp/.ezanvakti_yad_arayuz.pid && -n $(ps -p $( < /tmp/.ezanvakti_yad_arayuz.pid) -o comm=) ]]
  then
      printf "Yalnızca bir arayüz örneği çalışabilir.\n" >&2
      exit 1
  else
      printf "$ypid" > /tmp/.ezanvakti_yad_arayuz.pid
  fi
}

function arayuz2_pid_denetle() {
  local ypid=$$

  if [[ -f /tmp/.ezanvakti_yad_arayuz2.pid && -n $(ps -p $( < /tmp/.ezanvakti_yad_arayuz2.pid) -o comm=) ]]
  then
      printf "Yalnızca bir arayüz2 örneği çalışabilir.\n" >&2
      exit 1
  else
      printf "$ypid" > /tmp/.ezanvakti_yad_arayuz2.pid
  fi
}

function g_vakitleri_al() {
  denetle; bugun

  local kerahat_suresi=2700 #45 dk
  local kv_gunes=$(( gunes + kerahat_suresi ))
  local kv_ogle=$(( ogle - kerahat_suresi ))
  local kv_aksam=$(( aksam - kerahat_suresi ))

  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah_n; kalan
      v_ileti='Sabah ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'

  elif (( UNIXSAAT > sabah )) && (( UNIXSAAT < gunes ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 1</b>'

  elif (( UNIXSAAT == gunes ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Güneş Doğuş Vakti</b>'

  elif (( UNIXSAAT > gunes )) && (( UNIXSAAT <= kv_gunes ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 2</b>'

  elif (( UNIXSAAT > kv_gunes)) && (( UNIXSAAT < kv_ogle ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kuşluk Vakti</b>'

  elif (( UNIXSAAT < ogle )) && (( UNIXSAAT >= kv_ogle ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 3</b>'

  elif (( UNIXSAAT > ogle )) && (( UNIXSAAT < ikindi ))
  then
      bekleme_suresi $ikindi_n; kalan
      v_ileti='İkindi ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Öğle Vakti</b>'

  elif (( UNIXSAAT > ikindi )) && (( UNIXSAAT < kv_aksam ))
  then
      bekleme_suresi $aksam_n; kalan
      v_ileti='Akşam ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 4</b>'

  elif (( UNIXSAAT < aksam )) && (( UNIXSAAT >= kv_aksam ))
  then
      bekleme_suresi $aksam_n; kalan
      v_ileti='Akşam ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 5</b>'

  elif (( UNIXSAAT < yatsi ))
  then
      bekleme_suresi $yatsi_n; kalan
      v_ileti='Yatsı ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Akşam Vakti</b>'

  elif (( UNIXSAAT <= yeni_gun ))
  then
      v_ileti='Yeni gün için bekleniyor..'
      v_kalan=
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'
  fi
}

function g_vakitleri_yaz() {
  local sabah gunes ogle
  local ikindi aksam yatsi
  local vakitsiz

  vakitsiz="<b>Şimdi Kerahat Vakti 1</b>|<b>Şimdi Kerahat Vakti 2</b>"
  vakitsiz+="|<b>Şimdi Kerahat Vakti 3</b>|<b>Şimdi Kuşluk Vakti</b>"
  vakitsiz+="|<b>Şimdi Kerahat Vakti 5</b>"

  if [[ ${vakit_bilgisi} = '<b>Şimdi Yatsı Vakti</b>'  ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Güneş Doğuş Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Öğle Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = @('<b>Şimdi Kerahat Vakti 4</b>') ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Akşam Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = @(${vakitsiz}) ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"
  fi

  printf "${VAKIT_BICIMI}" "${sabah}" "$sabah_n" "${gunes}" \
         "$gunes_n" "${ogle}" "$ogle_n" "${ikindi}" "$ikindi_n" "${aksam}" \
         "$aksam_n" "${yatsi}" "$yatsi_n"
}

function g_secim_goster() {
  yad --title "${AD^} $SURUM - ${secim_basligi}" --text-info --filename=/tmp/ezanvakti-6 \
      --width=560 --height=300 --wrap --button='gtk-close' --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
      --back="$ARKAPLAN_RENGI" --fore="$YAZI_RENGI" --mouse --sticky
}

function g_hakkinda() {
  yad --text "\t\t<b><big>${AD^} ${SURUM}</big></b>
\"GNU/Linux için ezan vakti bildirici\"

   <a href= 'https://gitlab.com/fbostanci/ezanvakti' >Ezanvakti Sayfası</a>
   <a href= 'https://github.com/fbostanci/ezanvakti' >Ezanvakti Github Sayfası</a>

Copyright (c) 2010-$(date +%Y) Fatih Bostancı
GPL 3 ile lisanslanmıştır.\n" \
  --title "${AD^} ${SURUM} - Hakkında" --fixed --image-on-top \
  --button='gtk-close' --sticky --center \
  --image=${VERI_DIZINI}/simgeler/ezanvakti2.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png
}

function pencere_bilgi() {

yad --form --separator=' ' --title="${AD^} $SURUM" --text "${mplayer_ileti}" \
  --image=${VERI_DIZINI}/simgeler/ezanvakti.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
  --button='gtk-cancel:127' --button='gtk-close:0' --mouse --fixed

  case $? in
    *)
      echo stop > /tmp/mplayer-$$.pipe 2>/dev/null
      rm -f /tmp/mplayer-$$.pipe &>/dev/null
      ;;
  esac
}

function ozel_pencere() {
  local strng donus
  local str str2

strng=$(yad --form \
--field=Okuyucu:CB \
'!Saad el Ghamdi!As Shatry!Ahmad el Ajmy!Yerel Okuyucu' \
--field=Sure:CB \
"${sure_listesi}" \
--button='gtk-go-back:151' --button='gtk-media-play:152' --button='gtk-quit:153' \
--image=${VERI_DIZINI}/simgeler/ezanvakti.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
--title "${AD^} $SURUM" --sticky --center --fixed)

donus=$(echo $?)

declare -x $(sed 's:|: :g' <<< "$strng" | gawk '{print "str="$1 "\nstr2="$2}')

case $donus in
  151)
    arayuz ;;
  152)
    [[ -z $str2 ]] && ozel_pencere
    sure=$(cut -d'-' -f1 <<<"$str2")

    if [[ ${str} = Saad el Ghamdi ]]
    then
        okuyucu=AlGhamdi
    elif [[ ${str} = As Shatry ]]
    then
        okuyucu=AsShatree
    elif [[ ${str} = Ahmad el Ajmy ]]
    then
        okuyucu=AlAjmy
    else
        okuyucu='Yerel Okuyucu'
    fi

    if (( ${#sure} == 1 ))
    then
        sure=00$sure
    elif (( ${#sure} == 2 ))
    then
        sure=0$sure
    fi

    if [[ ${okuyucu} = Yerel Okuyucu ]]
    then
        if [[ -f "${YEREL_SURE_DIZINI}/$sure.mp3" ]]
        then
            dinletilecek_sure="${YEREL_SURE_DIZINI}/$sure.mp3"
        else
            ozel_pencere
        fi
    else
        dinletilecek_sure="http://www.listen2quran.com/listen/${okuyucu}/$sure.mp3"
    fi

    mplayer_ileti="$(gawk -v sira=$sure '{if(NR==sira) print $4;}' < ${VERI_DIZINI}/veriler/sure_bilgisi) suresi dinletiliyor..\
    \n\n Okuyan : ${str}"
    pencere_bilgi & mplayer_calistir "${dinletilecek_sure}"
    pkill yad >/dev/null 2>&1; ozel_pencere ;;
  153)
    exit 0 ;;
esac
}

# vim: set ft=sh ts=2 sw=2 et:
