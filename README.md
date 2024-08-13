# daily_planner

FINALLLY

fuck god damn

https://stackoverflow.com/questions/54483617/flutter-daemon-terminated-when-i-try-to-launch-my-app fuck me

anyways:

Flutter To-Do list app with firebase and sqlite backend yadayada.

i ll do android and web because firebase doesn t support linux -_- and only beta supports windows and mac.

STRUCTURE:
material design: auth screen -> dashboard -> form for adding and editing entries
                                          -> settings (icon) screen with theme switch

light / dark mode toggle with persistance storage -- DONE

Firebase Project done and linked to the app -- DONE

FIREBASE AUTH WITH COOL UI, EMAIL/PASS with PASS RESET VIA MAIL LINKS -- DONE
HELL YEAH -- also displaying the currently logged in user under info dialog -- DONE

Good UI design and structure -- DONE

https://stackoverflow.com/questions/54483617/flutter-daemon-terminated-when-i-try-to-launch-my-app fuck me
IT HAPPENED AGAIN!!!!!

TODO done:
make title (and later other things:  data scadentă nu poate fi în trecut) obligatory to input / not leave empty -- DONE
Sent form data to cloud firestore -- DONE


TODO not done:
READ from firestore
add / edit tasks from the form info into the homescreen/dashboard

sync them with firebase firestore when online
persist the tasks offline with get ???

doable si must:

+- Sarcinile ar trebui să fie afișate într-o listă, ordonată în funcție de prioritate (de exemplu, Urgent, Important, Normal).
+- Fiecare sarcină trebuie să aibă următoarele atribute: titlu, descriere, prioritate, data scadentă, stare (completată/necompletată).

#### 4. Marcare Sarcini ca Finalizate:
+- Oferă utilizatorilor opțiunea de a marca sarcinile ca finalizate sau nefinalizate.
+- Sarcinile finalizate ar trebui să fie evidențiate sau mutate într-o secțiune separată.

not so doable inca

#### 5. Persistența Datelor:
+- Folosește o bază de date SQL sau NOSQL externa la care sa te autentifici securizat. Înscrie datele în dotenv, pe care să îl INCLUZI in repository
+- Asigură sincronizarea automată a datelor locale cu Firebase Firestore atunci când utilizatorul este conectat la internet.

#### 6. Notificări Push:
+- Implementarea notificărilor push pentru a reaminti utilizatorilor de sarcinile scadente în curând. Poți folosi Firebase Cloud Messaging (FCM) pentru acest lucru.

Using
(insert final lib list when done)