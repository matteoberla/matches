import 'package:flutter/cupertino.dart';
import 'package:matches/models/timeline_models/classifica_entry_model.dart';

// Definizione dei colori
const Color colorPrimo = Color(0xFFFFD700); // Oro
const Color colorSecondo = Color(0xFFC0C0C0); // Argento
const Color colorTerzo = Color(0xFFCD7F32); // Bronzo
const Color colorQuarto = Color(0xFF4A90D9);
const Color colorQuinto = Color(0xFF7B68EE);
const Color colorSesto = Color(0xFF20B2AA); // Light Sea Green
const Color colorSettimo = Color(0xFFFF8C00); // Dark Orange
const Color colorOttavo = Color(0xFF3CB371); // Medium Sea Green
const Color colorNono = Color(0xFFDC143C); // Crimson
const Color colorDecimo = Color(0xFF4682B4); // Steel Blue

const List<ClassificaEntry> classificaEu2016 = [
  ClassificaEntry(pos: 1, nome: "ESCOBAR DE BOGOTA' 428 Pt", color: colorPrimo),
  ClassificaEntry(pos: 2, nome: 'LUCA CICCHELERO 428 Pt', color: colorSecondo),
  ClassificaEntry(pos: 3, nome: 'G&F GOLLIN 420 Pt', color: colorTerzo),
  ClassificaEntry(pos: 4, nome: 'DIMITRI 407 Pt', color: colorQuarto),
  ClassificaEntry(pos: 5, nome: 'UGO 398 Pt', color: colorQuinto),
  ClassificaEntry(pos: 6, nome: "VITTO' 382 Pt", color: colorSesto),
  ClassificaEntry(
      pos: 7, nome: 'PELLIZZARI FILIPPO 377 Pt', color: colorSettimo),
  ClassificaEntry(pos: 8, nome: 'VERINELLI 372 Pt', color: colorOttavo),
  ClassificaEntry(pos: 9, nome: 'CRISTIAN KROOS 370 Pt', color: colorNono),
  ClassificaEntry(
      pos: 10, nome: 'FEDERICO (GIOBBA JR.) 370 Pt', color: colorDecimo),
];

const List<ClassificaEntry> classificaMo2018 = [
  ClassificaEntry(pos: 1, nome: 'Renon 513 Pt', color: colorPrimo),
  ClassificaEntry(pos: 2, nome: 'Collina 495 Pt', color: colorSecondo),
  ClassificaEntry(pos: 3, nome: 'Flavia 438 Pt', color: colorTerzo),
  ClassificaEntry(pos: 4, nome: 'Angelina 434 Pt', color: colorQuarto),
  ClassificaEntry(pos: 5, nome: 'Mister Ugo 425 Pt', color: colorQuinto),
  ClassificaEntry(pos: 6, nome: 'Babu 422 Pt', color: colorSesto),
  ClassificaEntry(pos: 7, nome: 'Berto Luca 415 Pt', color: colorSettimo),
  ClassificaEntry(pos: 8, nome: 'Giggs 408 Pt', color: colorOttavo),
  ClassificaEntry(pos: 9, nome: 'Cristian kroos 404 Pt', color: colorNono),
  ClassificaEntry(pos: 10, nome: 'Ciucchino 402 Pt', color: colorDecimo),
];

const List<ClassificaEntry> classificaEu2020 = [
  ClassificaEntry(pos: 1, nome: 'PAOLO DEGA 403 Pt', color: colorPrimo),
  ClassificaEntry(pos: 2, nome: 'MARCHIORO FABIO 392 Pt', color: colorSecondo),
  ClassificaEntry(pos: 3, nome: 'MARCO REUS 391 Pt', color: colorTerzo),
  ClassificaEntry(pos: 4, nome: 'PELLIZZARI 384 Pt', color: colorQuarto),
  ClassificaEntry(pos: 5, nome: 'PELZ 23 383 Pt', color: colorQuinto),
  ClassificaEntry(pos: 6, nome: 'LELE ZOCKI 378 Pt', color: colorSesto),
  ClassificaEntry(pos: 7, nome: 'VALENTE ENRICO 376 Pt', color: colorSettimo),
  ClassificaEntry(pos: 8, nome: 'CALLO 375 Pt', color: colorOttavo),
  ClassificaEntry(pos: 9, nome: 'VITTORIO SUMAN 372 Pt', color: colorNono),
  ClassificaEntry(pos: 10, nome: 'FRATELLI LEON 369 Pt', color: colorDecimo),
];

const List<ClassificaEntry> classificaMo2022 = [
  ClassificaEntry(pos: 1, nome: 'GIOBBA 506 Pt', color: colorPrimo),
  ClassificaEntry(pos: 2, nome: 'MARCHIORO FABIO 504 Pt', color: colorSecondo),
  ClassificaEntry(pos: 3, nome: 'TOGNI 488 Pt', color: colorTerzo),
  ClassificaEntry(pos: 4, nome: 'MARCO REUS 473 Pt', color: colorQuarto),
  ClassificaEntry(pos: 5, nome: 'STROBBE L. 469 Pt', color: colorQuinto),
  ClassificaEntry(pos: 6, nome: 'NICOLA FABRIS 466 Pt', color: colorSesto),
  ClassificaEntry(pos: 7, nome: 'ALE DAL MORO 466 Pt', color: colorSettimo),
  ClassificaEntry(pos: 8, nome: 'PIERO STECCON 460 Pt', color: colorOttavo),
  ClassificaEntry(pos: 9, nome: 'GIAMBATTISTA A. 460 Pt', color: colorNono),
  ClassificaEntry(pos: 10, nome: 'UGO SIBELLA 442 Pt', color: colorDecimo),
];

const List<ClassificaEntry> classificaEu2024 = [
  ClassificaEntry(pos: 1, nome: 'pigia 406 Pt', color: colorPrimo),
  ClassificaEntry(pos: 2, nome: 'Trinacria 399 Pt', color: colorSecondo),
  ClassificaEntry(pos: 3, nome: 'Fede penzo 394 Pt', color: colorTerzo),
  ClassificaEntry(pos: 4, nome: 'MarcoCave 387 Pt', color: colorQuarto),
  ClassificaEntry(pos: 5, nome: 'filippi.lorenzo 379 Pt', color: colorQuinto),
  ClassificaEntry(pos: 6, nome: 'checco 378 Pt', color: colorSesto),
  ClassificaEntry(pos: 7, nome: 'GioERfutbol 377 Pt', color: colorSettimo),
  ClassificaEntry(pos: 8, nome: 'Togni 377 Pt', color: colorOttavo),
  ClassificaEntry(pos: 9, nome: 'Symosimo 376 Pt', color: colorNono),
  ClassificaEntry(pos: 10, nome: 'Vittorio Summano 375 Pt', color: colorDecimo),
];

const List<ClassificaEntry> classificaMo2026 = [
  ClassificaEntry(pos: 1, nome: '???', color: Color(0xFFFFD700)),
  ClassificaEntry(pos: 2, nome: '???', color: Color(0xFFC0C0C0)),
  ClassificaEntry(pos: 3, nome: '???', color: Color(0xFFCD7F32)),
];
