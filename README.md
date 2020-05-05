Son Güncelleme:  Thu, 23 Apr 2020 15:58:09 +0300

[![GitHub release](https://img.shields.io/github/release/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti)
[![GitHub tag](https://img.shields.io/github/tag/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti)
[![license](https://img.shields.io/github/license/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti)
[![AUR](https://img.shields.io/aur/version/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti)
[![GitHub issues](https://img.shields.io/github/issues/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti/issues)

<br>

Ezanvakti 7.2 GNU/Linux için ezan vakti bildirici
====
<br>

|***YAD Arayüz 1***| ***YAD Arayüz 2***|***YAD Arayüz 3***|
| :-------: | :-------: | :-------: |
|![yad_gui](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/44585586f8d1317828b4b10f09fcb2b3/yad_gui.png)|![yadgui2](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/557430b983641e1895160260f53c6758/yadgui2.png)|![yadgui3](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/9bd336024d37e121f3535bd6041f89c4/yadgui3.png)|

| ***Qt Arayüz*** |***Uçbirim Arayüz***|
| :-------: | :-------: |
|![ezanvakti-qt-gui](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/8fa462cfa97ad07c6015d86079b63db6/ezanvakti-qt-gui-1.png)|![tui](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/4930b67127a41e47f80553eebe206552/tui.png)|

<br>

HAKKINDA
==

Ezanvakti, T.C. Diyanet İşleri Başkanlığı sitesinden bulunduğunuz ülke
ve şehir için aylık bazda ezan vakitleri çizelgesini alarak vakti
geldiğinde ezan okuyan ve bildirim veren bir uygulamadır.

Kullandığı dosyaları ve ayarları yapılandırma dosyasından
okuduğundan kullanıcıya geniş özelleştirme desteği sunar.

Genel Özellikleri
=
*  Diyanet sitesindeki tüm ülke ve şehirler için aylık vakitleri alma.
*  Otomatik ezan vakitleri güncelleme.
*  Ezan vakitlerini ve vakitlere ne kadar süre kaldığını
   toplu/tekil gösterme. (--vakitler)
*  Vakitlerde ezan okunma/okunmama seçimi.
*  İftar vaktine ne kadar süre kaldığını gösterme. (--iftar)
*  İmsak vaktine ne kadar süre kaldığını gösterme. (--imsak)
*  Sıradaki vakit, ve vakte ne kadar süre kaldığını gösterme. (-vt)
*  Arayüzden ve uçbirimden kerahat vakitlerini gösterebilme. (-vk)
*  Bulunduğunuz konum için bayram namazı vakitlerini gösterme. (-vm)
*  Qt arayüz desteği [Gitlab](https://gitlab.com/fbostanci/ezanvakti-qt-gui) [Github](https://github.com/fbostanci/ezanvakti-qt-gui)
*  Arayüzde hicri tarih gösterimi
*  Arayüz HTML renk özelleştirmeleri
*  Cuma günü isteğe bağlı sela okunması (süre ayarlı)
*  Sistem açılışında 3 farklı kip<br>
   <pre>
    1: beş vakit (öntanımlı kip)
    2: ramazan (yalnızca iftar ve imsak vakitlerinde ezan okunur.)
    0: kapalı (arkada çalışmaz.)</pre>
*  Her vakit için farklı makamda ezan ve ezan duası.
*  Vakit ezanı okunurken desteklenen müzik oynatıcıyı ezan bitimine kadar duraklatma.<br>
   <pre>Desteklenen oynatıcılar: Spotify, Deadbeef, Clementine, Amarok, Rhythmbox,
                            Aqualung, Audacious, Banshee, Exaile, Cmus,
                            Moc, Qmmp, Juk</pre>
*  3 farklı okuyucu seçimli Kuran dinletme. (--kuran <seçenek>)<br>
   Seçenekler:<br>
   <pre>
   seçim: (-s <sure_no>)
   rastgele: (-r)
   hatim: (-h)
   günlük: (-g)</pre>
*  Sureleri; sure adı, ayet sayısı, sure numarası, cüz no ve indiği yer şeklinde listeleme. (--sureler)
*  İstenen surenin istenen ayet aralığını gösterme. (--aralik)
*  40 hadisten rastgele bir hadisi uçbirimden ya da bildirim baloncuğunda gösterme. (--hadis)
*  Esma-ül Hüsna'dan rastgele bir adı  uçbirimden ya da bildirim baloncuğunda gösterme. (--esma)
*  Diyanet sitesinden alınmış soru-yanıtlardan rastgele birini  uçbirimden
   ya da bildirim baloncuğunda gösterme. (--bilgi)
*  İçinde bulunulan yıla ait dini günleri ve geceleri listeleme. (--gunler)
*  Dini günler ve geceler için bir gün önceden bildirim verme.
*  Aylık ya da haftalık vakitleri listeleme. (-v7, -v30)
*  Conky uygulamasında kullanım için özel çıktılar. (--conky)
*  Sıradaki ezan vaktini (süre ayarlı) ve dini günleri anımsatma.
*  Sesli vakit anımsatma
*  Başlatıcı sağ tık seçke desteği (unity/desktop actions özelliği)
*  Geniş özelleştirme desteği.
*  Basit seviye arayüz(yad) desteği.

[Ekran görüntüleri için tıklayınız.](https://gitlab.com/fbostanci/ezanvakti/wikis/ekran-goruntuleri)
=

<br><br>

BAĞIMLILIKLAR
==
*    bash
*    sed
*    gawk
*    grep
*    libnotify
*    ffmpeg ya da mplayer
*    wget ya da curl

<br>

**EK ÖZELLİKLERİN KULLANIMI  İÇİN GEREKLİ (kullanmak isteniyorsa) BAĞIMLILIKLAR**

*  bash-completion  (Bash tamamlama desteği)
*  yad >=6.0  (Arayüz desteği)

<br><br>

KURULUM ve KALDIRMA
===
<br>

**Pardus için Launchpad PPA üzerinden kurulum:**

Bu depoda Pardus 19 XFCE için öntanımlı ayarlar özelleştirilmiştir.

`echo 'deb http://ppa.launchpad.net/fbostanci/pardus/ubuntu bionic main' | sudo tee /etc/apt/sources.list.d/ezanvakti-bionic.list`

`sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1651E3776FB72115`

`sudo apt-get update`

`sudo apt-get install ezanvakti`

Qt arayüzü kullanmak için:

`sudo apt-get install ezanvakti-qt-gui`

Pardus deposundaki Qt sürümleri, Ubuntu bionic(18.04) ile uyumludur. Bu sebeple bionic deposu seçilmiştir.

<br>

**Archlinux için kurulum:**

[AUR](https://aur.archlinux.org/) üzerinde uygulama bulunmaktadır.
AUR yardımcı uygulamanızla güncel sürümü kurabilirsiniz.

ör: Pacaur kullanıyorsanız:

`pacaur -Sa ezanvakti`

Qt arayüzü kullanmak için:

`pacaur -Sa ezanvakti-qt-gui`

<br>

**Ubuntu için Launchpad PPA üzerinden kurulum:**

Depo ubuntu 19.10 ve 20.04 içindir.

`sudo add-apt-repository ppa:fbostanci/distroguide`

`sudo apt-get update`

`sudo apt-get install ezanvakti`

Qt arayüzü kullanmak için:

`sudo apt-get install ezanvakti-qt-gui`

<br>

**Diğer dağıtımlar için (kaynak koddan) kurulum:**

`sudo make PREFIX=/usr sysconfdir=/etc install`

komutunu verin. Eğer paketleme yapıyorsanız, DESTDIR ile paket kurulum dizinini girin.

<br>

**kaldırma için:**

`sudo make PREFIX=/usr sysconfdir=/etc uninstall`

komutunu girin.

<br><br>

KULLANIM ve YAPILANDIRMA
==
Uygulamanın kullanımı ve yapılandırma ayarları için man dosyasına bakın.

<br>

Kullanım için:
`man ezanvakti`

Yapılandırma bilgileri için:
`man 5 ezanvakti-ayarlar`

Man dosyalarını pdf olarak indirmek için [wiki sayfasına](https://gitlab.com/fbostanci/ezanvakti/-/wikis/home) bakabilirsiniz.

<br><br>

LİSANS
==

Ezanvakti GPL 3 ile lisanslanmıştır. Ayrıntılar için COPYING dosyasına bakın.

Kullanılan ezan ses dosyaları İsmail COŞAR'a aittir.
