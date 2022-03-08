[license-url]: https://github.com/GatienVilain/lampe-tactile-adaptatif/blob/master/LICENSE "Ouvre la page de la licence"
[license-image]: https://img.shields.io/badge/license-MPL%20v2.0-blue.svg
[releases-url]: https://github.com/GatienVilain/lampe-tactile-adaptatif/releases "Ouvre la page des versions du projet"
[issues-url]: https://github.com/GatienVilain/lampe-tactile-adaptatif/issues "Ouvre la page des problèmes rencontrés"
[auteur-gatien-url]: https://github.com/GatienVilain "Ouvre la page GitHub de Gatien Vilain"

[presentation-image-url]: ./presentation/systeme-complet.png
[presentation-video-url]: ./presentation/systeme-complet.mp4



<div align="center">

# Lampe tactile à éclairage adaptatif
[![license][license-image]][license-url]

</div>

Dans le cadre d'un projet d'électronique de première année d'école d'ingénieurs à **Junia ISEN Lille**, il nous a été demandé de concevoir le circuit d'une source lumineuse s'adaptant à l'éclairage ambiant et comprenant plusieurs modes d'éclairage actionné par un bouton tactile.

[![système complet de la lampe tactile à éclairage adaptatif][presentation-image-url]][presentation-video-url]

## Fonctionnalités

- [x] Détection du niveau d'éclairage d'une pièce
- [x] Détection d'un appui sur le bouton tactile
- [x] Sélection du mode d'éclairage
  - [x] Éclairage éteint
  - [x] Éclairage allumé
  - [x] Éclairage adaptatif
  - [x] Éclairage clignotant
- [x] Indicateur de mode d'éclairage

## Configuration nécessaire

Il est nécessaire de disposer d'un environnement de développement pour microcontrôleur supportant la référence **Microchip PIC18F25K40**. Nous avons utilisé [MPLAB X IDE v5.35](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide#)

## Installation

Télécharger la dernière version du projet sous la rubrique [releases][releases-url] ou cloner le dépôt GitHub sur votre machine, en vous plaçant dans le répertoire où vous souhaitez le cloner et exécuter la commande suivante dans votre [invite de commande](https://lecrabeinfo.net/ouvrir-linvite-de-commandes-sur-windows.html) :
```PowerShell
git clone https://github.com/GatienVilain/lampe-tactile-adaptatif.git
```

## Problèmes ?

Si vous rencontrez des problèmes à l'utilisation, veuillez ouvrir un billet sous la rubrique [issues][issues-url].
Bien que ce projet ne soit plus actif, nous essayerons d'y jeter un coup d'oeil.

## Auteurs

Le projet a été réalisé par Dorian LAROUZIERE et [Gatien VILAIN][auteur-gatien-url]