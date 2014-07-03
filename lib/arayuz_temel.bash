#
#
#
#
#

AD=ezanvakti
SURUM=6.0
DUZELTME=@duzeltme@

BILESEN_DIZINI=@libdir@/ezanvakti
VERI_DIZINI=@datadir@/ezanvakti

# Öntanımlı ayarları al.
. @sysconfdir@/ezanvakti/ayarlar

#  Öntanımlı ayarlardan gelen değerlerin üzerine yazılacak.
#
# Kullanıcı ayarlarını al.
. "${EZANVAKTI_AYAR}" ||
  { printf "${EZANVAKTI_AYAR} dosyası okunabilir değil.\n Çıkılıyor...\n"; exit 1; }

EZANVAKTI_DIZINI="${XDG_CONFIG_HOME:-$HOME/.config}"/ezanvakti
EZANVAKTI_AYAR="${EZANVAKTI_DIZINI}"/ayarlar

[[ ! -d "${EZANVAKTI_DIZINI}" ]] && mkdir -p "${EZANVAKTI_DIZINI}"
[[ ! -f "${EZANVAKTI_AYAR}"   ]] &&
  sed "s:\(EZANVERI_DIZINI=\).*:\1\'${EZANVAKTI_DIZINI}\':" < @sysconfdir@/ezanvakti/ayarlar > "${EZANVAKTI_AYAR}"

EZANVERI=${EZANVAKTI_DIZINI}/${EZANVERI_ADI}
MPLAYER="mplayer -really-quiet -volume $SES"

declare -A ARAYUZ_YUKLENEN_BILESENLER

# http://git.archlinux.fr/yaourt.git/tree/src/lib/util.sh.in ( load_lib() )
function arayuz_bilesen_yukle() {
  while [[ $1 ]]
  do
    (( ARAYUZ_YUKLENEN_BILESENLER[$1] )) && return 0
    if [[ ! -r "${BILESEN_DIZINI}/$1.bash" ]]
    then
        printf "$1.bash dosyası bulunamadı.\n"
        exit 1
    fi
    . "${BILESEN_DIZINI}/$1.bash" || printf "$1.bash bileşeninde sorun var.\n"
    ARAYUZ_YUKLENEN_BILESENLER[$1]=1
    shift
  done
}

function arayuz_vakitler() {
     export $(gawk 'BEGIN{tarih = strftime("%d.%m.%Y")} {if($1 ~ tarih) \
    {printf \
    "sabah_n=%s\ngunes_n=%s\nogle_n=%s\nikindi_n=%s\naksam_n=%s\nyatsi_n=%s"\
    , $3,$2,$4,$5,$6,$7}}' "${EZANVERI}")

   printf "${VAKIT_BICIMI}" 'Sabah' "$sabah_n" 'Güneş' \
      "$gunes_n" 'Öğle' "$ogle_n" 'İkindi' "$ikindi_n" 'Akşam' \
      "$aksam_n" 'Yatsı' "$yatsi_n"
}

# Ezanveri dosyası gerektiren işlemlerde ilk önce bu fonksiyon çağrılacak.
#
# ezanveri dosyasının kullanıldığı işlemler için olumsuz durumları denetle.
function denetle() {
  local ksatir
  # ezanlar ve iftarimsak fonksiyonları özyinelemeli çalıştığı için
  # gün değişiminde tarihi güncellemek için tarih, denetle fonksiyonu içine alındı.
  TARIH=$(date +%d.%m.%Y)
  SAAT=$(date +%H%M)
  # 08, 09 için oluşan sekizli sayı hatasının önüne geçmek için saatin,
  # aritmetik karşılaştırmalarda kullanılması için UNIX ikilik saatine çevirdik.
  UNIXSAAT=$(date -d "$SAAT" +%s)

  [[ ! -f ${EZANVERI} ]] && { # ezanveri dosyası yoksa
    (( GUNCELLEME_YAP )) && { arayuz_bilesen_yukle guncelleyici; guncelleme_yap;} || {
      printf '%b%b\n%b\n' \
        "${RENK7}${RENK2}${EZANVERI}" \
        "${RENK3} dosyası bulunamadı." \
        "Çıkılıyor...${RENK0}"
      exit 1
    }
  }

  # Bugüne ait tarih ezanveri dosyasında yoksa
  [[ -z $(grep -o ${TARIH} "${EZANVERI}") ]] && {
    (( GUNCELLEME_YAP )) && { arayuz_bilesen_yukle guncelleyici; guncelleme_yap;} || {
      printf '%b%b\n%b\n' \
        "${RENK7}${RENK2}${EZANVERI_ADI}" \
        "${RENK3} dosyası güncel değil." \
        "Çıkılıyor...${RENK0}"
      exit 1
    }
  }

  # ezanveri dosyasından tarih bloğunu ayıklayıp son tarih satır no dan bugünkünü çıkardık.
  ksatir=$(gawk -v tarih=${TARIH} '/^[0-9][0-9]\.[0-9]*\.[0-9]*/ {if($1 ~ tarih) bsatir = NR}; \
    /^[0-9][0-9]\.[0-9]*\.[0-9]*/ {} END {tsatir = NR}; END {print(tsatir-bsatir)}' "${EZANVERI}")
  let ksatir++

  (( ksatir <= 7 )) && { # sonuç 7 ya da 7'den küçükse
    (( GUNCELLEME_YAP )) && { arayuz_bilesen_yukle guncelleyici; guncelleme_yap;}

    # Betiğin mevcut oturum boyunca sadece ilk çalışmada bildirim vermesi
    # için çerez dosya denetimi ekledik. Gün değişimi durumu için (mevcut oturum devam ediyorsa)
    # ayrıca dosyaya tarih uzantısı da ekledik.
    [[ ! -f /tmp/eznvrgncldntle_$(date +%d%m%y) ]] && {
      notify-send "Ezanvakti $SURUM" "${EZANVERI_ADI} dosyanız\n\t$ksatir gün\nsonra güncelliğini yitirecek." \
        -i ${VERI_DIZINI}/simgeler/ezanvakti.png -t $GUNCELLEME_BILDIRIM_SURESI"000" -h int:transient:1
      :> /tmp/eznvrgncldntle_$(date +%d%m%y)
    }
  }
}

# Eğer hedef süre bugün içerisindeyse bu fonksiyon kullanılacak.
function bekleme_suresi() {
  bekle=$(($(date -d "$1" +%s) - $(date +%s) + EZAN_OKUNMA_SURESI_FARKI))
}

#  Eğer hedef süre yarına aitse bu fonksiyon kullanılacak.
function bekleme_suresi_yarin() {
  bekle=$((86400 - $(date +%s) + $(date -d "$1" +%s) + EZAN_OKUNMA_SURESI_FARKI))
}

# bekleme süresi fonksiyonlarından gelen bekle değerini
# saat, dakika ve saniyeye çeviren fonksiyon
function kalan() {
  kalan_sure=$(printf '%02d saat : %02d dakika : %02d saniye' \
    $((bekle/3600)) $((bekle%3600/60)) $((bekle%60)))
}




# vim: set ft=sh ts=2 sw=2 et:
