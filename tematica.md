### Proba de Interviu - Programare în Flutter

#### Durată estimată: 12 ore

#### Scopul Probei:
Această probă are scopul de a evalua abilitățile tale de programare în Flutter, incluzând design-ul UI, gestionarea stării, integrarea cu API-uri externe și gestionarea datelor locale. Proiectul ar trebui să fie funcțional și să respecte bunele practici în dezvoltarea de aplicații mobile.

---

### Cerințe:

#### Aplicația: *„Daily Planner”*

Vei dezvolta o aplicație mobilă de tip „Daily Planner” care să permită utilizatorilor să își gestioneze sarcinile zilnice. Aplicația va include următoarele funcționalități:

#### 1. *Ecran de Autentificare/Înregistrare:*
   - Creează un ecran de autentificare unde utilizatorii pot să se înregistreze și să se autentifice folosind adresa de e-mail și o parolă. Este spre beneficiul tau sa folosești Auth0/Oauth/TFA
   - Utilizează Firebase Authentication sau altă tehnologie pentru a gestiona înregistrarea și autentificarea utilizatorilor.

#### 2. *Dashboard cu Lista de Sarcini:*
   - După autentificare, utilizatorul va fi direcționat către un ecran principal (Dashboard) unde își poate vedea sarcinile zilnice.
   - Sarcinile ar trebui să fie afișate într-o listă, ordonată în funcție de prioritate (de exemplu, Urgent, Important, Normal).
   - Fiecare sarcină trebuie să aibă următoarele atribute: titlu, descriere, prioritate, data scadentă, stare (completată/necompletată).

#### 3. *Adăugarea și Editarea Sarcinilor:*
   - Asigură-te că utilizatorii pot adăuga noi sarcini prin intermediul unui formular simplu.
   - Permite utilizatorilor să editeze sarcinile existente.
   - Implementarea unei validări de bază pentru câmpuri (de exemplu, titlu obligatoriu, data scadentă nu poate fi în trecut).

#### 4. *Marcare Sarcini ca Finalizate:*
   - Oferă utilizatorilor opțiunea de a marca sarcinile ca finalizate sau nefinalizate.
   - Sarcinile finalizate ar trebui să fie evidențiate sau mutate într-o secțiune separată.

#### 5. *Persistența Datelor:*
   - Folosește o bază de date SQL sau NOSQL externa la care sa te autentifici securizat. Înscrie datele în dotenv, pe care să îl INCLUZI in repository
   - Asigură sincronizarea automată a datelor locale cu Firebase Firestore atunci când utilizatorul este conectat la internet.

#### 6. *Notificări Push:*
   - Implementarea notificărilor push pentru a reaminti utilizatorilor de sarcinile scadente în curând. Poți folosi Firebase Cloud Messaging (FCM) pentru acest lucru.

#### 7. *Interfață Grafică Modernă și Responsivă:*
   - Aplicația ar trebui să aibă o interfață grafică plăcută și modernă, adaptată atât pentru telefoane cât și pentru tablete.
   - Utilizează widget-uri Flutter personalizate acolo unde este necesar.

#### 8. *Setări:*
   - Include un ecran de setări unde utilizatorii pot ajusta preferințele aplicației, precum tema (light/dark mode).

---
### Criterii de Evaluare:

1. *Funcționalitate și Completență:*
   - Aplicația trebuie să fie complet funcțională și să includă toate cerințele specificate.

2. *Calitatea Codului:*
   - Codul trebuie să fie curat, bine structurat și documentat corespunzător.
   - Folosirea arhitecturii de tip MVVM sau un alt model arhitectural este un plus. Spre exemplu, MVC

3. *Design UI/UX:*
   - Interfața aplicației trebuie să fie modernă, intuitivă și responsivă.
   - Utilizează Material Design pentru o experiență consistentă.

4. *Performanță:*
   - Aplicația ar trebui să funcționeze fără probleme, fără întârzieri majore sau blocări.

5. *Originalitate și Creativitate:*
   - Orice funcționalitate suplimentară sau îmbunătățire a UI/UX-ului este apreciată.

### Instrucțiuni de Predare:
- Predă aplicația într-un repository Git (GitHub, GitLab, etc.).
- Include un fișier README.md cu instrucțiuni de instalare, tehnologii folosite și orice alte detalii relevante despre aplicație.
- Asigură-te că proiectul poate fi compilat și rulat pe un emulator sau pe un dispozitiv fizic fără probleme.
- INCLUDE EXECUTABILUL spre a o putea instala și nota.
Din acest moment ai 30 de ore.
Aplicația se poate realiza Rezonabil in 10.
Nu trebuie sa integrezi tot, trebuie doar sa faci ceva performant.
