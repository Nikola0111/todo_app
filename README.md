# todo_app

Resenje je implementirano pomocu flutter verzije 2.2.3. Ako bude bilo problema u todo_list_item.dart klasi pri pokretanju, uklonite `shape` property i probajte pokrenuti opet. Ako je problem negde drugde u projektu mozete me kontaktirati.

## Nedovrsene funkcionalnosti

Zbog obima zadatak i nedostatka vremena tokom prosle nedelje nisam stigao da implementiram sledece funkcionalnosti: kalendar u upcoming, ucitavanje dodatnih 10 lista, ali imam ideju kako bih uradio.

U klasi `ListsDrawerSection` bih kreirao `ScrollController`, i na njega dodao listener koji bi se trigerovao svaki put kada bi korisnik skrolovao do dna `ListView`-a koji je zaduzen za prikaz listi. Taj event bih detektovao putem 2 uslova, prvi je `_scrollController.pixels.atEdge` a drugi nesto slicno `_scrollController.pixels == MediaQuery.of(context).size.height` (u sustini pokusao bih da nekako dobijem dno ekrana. Ako su zadovoljeni uslovi pokazao bih loader i ucitao nove liste, i procesuirao podatke opet i dodao ih u mapu sa `Todo` objektima. I naravno, taj controller bih dodelio `ListView.builder`-u koji je zaduzen za prikazivanje naziva lista.

## Autentifikacija pri pokretanju app

Autentifikaciju odmah pri pokretanju app nakon splash ekrana nije implementirana jer je za auth/me poziv potreban `access_token` koji se dobija samo pri uspesnom loginu, a njega nemam pri pokretanju app. Jedno moguce resenje za to je da cuvam `access_token` lokalno na telefonu i onda da ga ucitam pri pokretanju app.

## Reschedule u overdue sekciji i search 

Nije u potpunosti bilo jasno kako Reschedule funkcionise, da li se odnosi na sve todo-ove ili se mozda kada se klikne na Reschedule promeni ui tako da overdue todo-ovi imaju chechbox pored sebe na primer pa se selektuju kojim se menja datum, pa je za to samo UI odradjen. Takodje za search nije naznaceno da li je pretraga po sekciji nazivu todo-a.

## Overdue/Today/Upcoming sekcija u drawer-u

Nisam bio siguran kako funkcionise evidencija todo-ova u `DrawerHeader` sekciji, zato sam stavio da su brojevi ispod imena brojZavrsenihTaskova/brojUkupnihTaskova

## Unapredjenja resenja

Pored zavrsavanja svih funkcionalnosti, jedno od mogucih unapredjenja resenja bi bilo nalazenje nacina da `ListOfTodosBloc` ima samo jednu instancu koju onda nije potrebno prosledjivati u konstruktorima kako je uradjeno u zadatku, cime bi se onda klasa mogla rastaviti na vise manjih delova. Pada mi na pamet dependency injection putem getX paketa ili da se rucno implementira, ali nisam siguran da li je to moguce posto se dependency injection koristi obicno u kombinaciji sa servisima. 

Takodje smislio bih neki drugi nacin za filtriranje podataka pri ucitavanju ekrana, nested for loops postaju previse time consuming kako se dodaju novi todo-ovi
