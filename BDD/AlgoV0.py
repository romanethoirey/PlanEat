import pandas as pd
import numpy as np



##Creation de la table

#nb_users = int(input("Nombre d'utilisateurs :\n"))
nb_users = 100
users = [i for i in range(nb_users)]
#nb_plats = int(input("Nombre de plats :\n"))
nb_plats = 100
plats = [i for i in range(nb_plats)]
#nb_none = int(input("Nombre de plats non notés pour 5 plats notés :\n"))
nb_none = 10
notes = [None for i in range(nb_none)] + [1, 2, 3, 4, 5]

ratings = []
for i in users:
    for j in plats:
        ratings.append([i,j,notes[np.random.randint(0,len(notes))]])

table = pd.DataFrame(ratings, columns=['user','plat','note'])
table.dropna(inplace=True)
table.reset_index(drop=True, inplace=True)



##Création des dataframe par user

#Utilisateur reference
user = 0
df_user_ref = table[table['user'] == user]
liste_plats = list(df_user_ref['plat'])

df_comparaison = table[(table['user'] != user) & table['plat'].isin(liste_plats)]

#Liste des utilisateurs à comparer
liste_df_users = []
for i in df_comparaison['user'].unique():
    liste_df_users.append(df_comparaison[df_comparaison['user'] == i])



##Comparaison du profil de reference aux autres utilisateurs

#Liste des utilisateurs similaires
ecarts = []
score_similarite = []
for i in range(len(liste_df_users)):
    df_test = df_user_ref[df_user_ref['plat'].isin(liste_df_users[i]['plat'])]
    ecarts.append(np.mean(np.absolute(df_test['note'].to_numpy()-liste_df_users[i]['note'].to_numpy())))
    score_similarite.append((5-ecarts[-1])/5)

#Nombre d'utilisateurs similaires gardes
nb_comparaisons = 5
liste_min = [6 for i in range(nb_comparaisons)]
liste_pos = [-1 for i in range(nb_comparaisons)]
for i in range(nb_comparaisons):
    for j in range(len(ecarts)):
        if ecarts[j]<liste_min[i] and j not in liste_pos:
                liste_min[i] = ecarts[j]
                liste_pos[i] = j

liste_similaires = [table[table['user']==liste_df_users[i]['user'].unique()[0]] for i in liste_pos]



##Recommandations sans tri

liste_recommandations = []
seuil = 5
for i in range(nb_comparaisons):
    df_test = table[(table['user'] == liste_similaires[i]['user'].unique()[0])\
                    &(~table['plat'].isin(df_user_ref['plat'].to_numpy()))\
                    &(table['note'] >= seuil)]
    if not df_test.empty:
        liste_recommandations.append(df_test)
        print(df_test)