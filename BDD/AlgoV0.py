#!/usr/bin/env python
# coding: utf-8

# # Import des bibliothéques


import pandas as pd
import numpy as np
import json


# # Lecture du fichier d'entrée


with open('input.json') as f:
    data = json.load(f)


# # Tables des utilisateurs


#Utilisateurs de l'app
nb_users = 1000
users = [i for i in range(nb_users)]

#Plats présents dans l'app
nb_plats = 250
plats = [i for i in range(nb_plats)]

#Nombre de plats notés par les utilisateurs en moyenne
nb_note = 20
nb_none = int((1 - nb_note/nb_plats)*100)
notes = [None for i in range(nb_none)] + [1, 2, 3, 4, 5]

#Dataframe des notes
ratings = []
for i in users:
    for j in plats:
        ratings.append([i,j,notes[np.random.randint(0,len(notes))]])

table = pd.DataFrame(ratings, columns=['user','plat','note'])
table.dropna(inplace=True)
table.reset_index(drop=True, inplace=True)


# # Création des dataframe par utilisateurs


#Utilisateur de référence
user = data['user']
df_user_ref = table[table['user'] == user]

#Liste des plats notés par l'utilisateur de référence
liste_plats = list(df_user_ref['plat'])

#Dataframe avec tout les utilisateurs autres que la référence et ayant noté des plats de la liste
df_comparaison = table[(table['user'] != user) & table['plat'].isin(liste_plats)]

#Liste des utilisateurs à comparer
liste_df_users = []
liste_users = list(df_comparaison['user'].unique())
for i in liste_users:
    liste_df_users.append(df_comparaison[df_comparaison['user'] == i])


# # Comparaison de l'utilisateur de référence aux autres utilisateurs


#Liste des scores de similarité
score_similarite = []

"""
Le score de similarité est un coefficient compris entre 0 et 1 indiquant à quel point deux utilisateurs sont proches (1 étant identiques).
Ce score dépend (de manière linéaire dans ce modèle) de l'écart absolu moyen des notes de deux utilisateurs : un écart absolu moyen très
faible implique une similarité élevée. On prend, ainsi, le complément à 1 de l'écart absolu moyen divisé par 5 (les notes de l'application
étant sur 5, l'écart absolu moyen est compris entre 0 et 5).
"""

for i in range(len(liste_df_users)):
    score_similarite.append((5 - np.mean(np.absolute(df_user_ref[df_user_ref['plat'].isin(liste_df_users[i]['plat'])]['note'].to_numpy()-liste_df_users[i]['note'].to_numpy())))/5)


# # Recommandations pondérées par le score de similarité


#Nombre de recommandations à envoyer
nb_recommandations = data['nb_recommandations']

#Liste des recommandations à analyser
liste_recommandations = []

#Dataframe des plats non noté par l'utilisateur de référence mais notés par les autres utilisateurs
for i in range(len(liste_df_users)):
    df_temp = table[(table['user'] == liste_df_users[i]['user'].unique()[0])                    &(~table['plat'].isin(df_user_ref['plat'].to_numpy()))]
    if not df_temp.empty:
        liste_recommandations.append(df_temp)

df_recommandations = pd.concat(liste_recommandations)

#Liste des notes coefficientées sous forme de couples (plat,note)
liste_notes = []

for i in range(nb_plats):
    df_calcul = df_recommandations[df_recommandations['plat'] == i]
    
    if not df_calcul.empty:
        #Somme pondérée
        temp1 = 0
        #Coefficients
        temp2 = 0
        for j in range(len(df_calcul)):
            temp1 += df_calcul.iloc[j]['note']*score_similarite[liste_users.index(df_calcul.iloc[j]['user'])]
            temp2 += score_similarite[liste_users.index(df_calcul.iloc[j]['user'])]
        
        #Moyenne pondérée
        note = temp1/temp2
        liste_notes.append([i,note])

#On parcourt l'ensemble des plats et on en garde les meilleurs
df_recommandations = pd.DataFrame(liste_notes, columns=['plat','note']).sort_values(by=['note'], ascending=False).head(nb_recommandations).reset_index().drop(columns=['index'])


# # Renvoi du résultat sous forme d'un fichier JSON


df_recommandations.drop(columns=['note']).to_json('output.json')
