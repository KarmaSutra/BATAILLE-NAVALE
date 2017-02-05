//BUT: créer une bataille navale
//ENTREES: les lignes et colonnes où se situeront les bateaux, où les tirs se feront
//SORTIES: Les positions des bateaux, le retour si le tir a touché ou non

{
	CONST
		N=10;
		MAX=10;



	TYPE cell= ENREGISTREMENT

		ligne, colonne: ENTIER;
	FIN ENREGISTREMENT


	TYPE bateau= ENREGISTREMENT

		tbateau est un tableau d'intervalle [1..MAX] en cell;
	FIN ENREGISTREMENT


	TYPE flotte= ENREGISTREMENT

		tflotte est un tableau d'intervalle[1..MAX] en bateau;
	FIN ENREGISTREMENT

	TYPE terrain= ENREGISTREMENT

		tterrain est un tableau d'intervalle [1..N*N] en ENTIER;
	FIN ENREGISTREMENT








	procedure creation_terrain ( terrain_jeu en terrain)

		VAR
		i:ENTIER


	POUR i ALLANT DE 1 à (N*N)
		
		terrain_jeu.tterrain[i]<--0
		SI (i MOD 10)=0 ALORS
			ECRIRE terrain_jeu.tterrain[i]
		FIN SI                       			 //On cherche à obtenir un retour à la ligne chaque fois que i= un multiple de 10, ce ecrire est donc équivalent à un writeln)
		SINON ECRIRE terrain_jeu.tterrain[i]						//Ici, ECRIRE est équivalent à un write car on ne cherche pas le retour à la ligne. Le but est de créer deux dimensions différentes avec un tableau à une dimension.

	FIN POUR

	FIN PROCEDURE









	fonction comparaison_cell (cellule en cell, terrain_jeu en terrain) en booleen
	
	VAR
	comparaison: BOOLEEN


	IF tterrain[(cell.ligne-1)*10+cell.colonne]=1 THEN
		comparaison<- VRAI
	ELSE comparaison<- FAUX


	comparaison_cellule<--comparaison
	FIN FONCTION










	fonction creation_bateau (flottes en flotte, terrain_jeu en terrain) en booleen

	ECRIRE "Nous allons maintenant vous demander de placer 5 bateaux. Chaque bateaux occupe une cellule du jeu et sera détruit en un seul coup. Choisissez bien."

		i<--1

			POUR J ALLANT DE 1 à (MAX DIV 2)
			
					ECRIRE "Joueur 1, choisissez la ligne sur laquelle sera placée le bateau"
					LIRE flottes.tflotte[i].tbateau[j].ligne

					ECRIRE "choisissez la colonne sur laquelle sera placée le bateau"
					LIRE flottes.tflotte[i].tbateau[j].colonne


					terrain_jeu.tterrain[((flottes.tflotte[i].tbateau[j].ligne) -1)*10 + (flottes.tflotte[i].tbateau[j].colonne)]<--1
			FIN POUR

		i<--2
			POUR j ALLANT DE ((MAX DIV 2)+1) A MAX


				ECRIRE "Joueur 1, choisissez la ligne sur laquelle sera placée le bateau"
					LIRE flottes.tflotte[i].tbateau[j].ligne

					ECRIRE "choisissez la colonne sur laquelle sera placée le bateau"
					LIRE flottes.tflotte[i].tbateau[j].colonne


					terrain_jeu.tterrain[((flottes.tflotte[i].tbateau[j].ligne) -1)*10 + (flottes.tflotte[i].tbateau[j].colonne)]<--1
			FIN POUR
FIN FONCTION











fonction test_bateau (bateaux en bateau; x en entier) en BOOLEEN

	VAR
	terrain_jeu: terrain
	cellule:cell
	test: BOOLEEN




	
	comparaison cellule (terrain_jeu, cellule)
	
	SI comparaison_cellule ALORS

		x<-1
		
		TANT QUE test=FAUX FAIRE
		
			SI terrain_jeu.tterrain[(bateaux.tbateau[x].ligne -1)*10 + bateaux.tbateau[x].colonne]=1 ALORS
			test <-- VRAI
			SINON	x<--x+1
					test <-- FAUX
			FIN SI

		FIN TANT QUE

	
	FIN SI
	
	test_bateau<-- test

FIN FONCTION
			
	
			

fonction test_flotte (terrain_jeu en terrain; flottes en flotte, i en entier) en BOOLEEN

VAR
x: ENTIER
bateaux:bateau
cellule:cell
test: BOOLEEN

	test_bateau (bateaux, cellule, x)

	SI test_bateau ALORS
		i<--1
		TANT QUE test=FAUX FAIRE
			SI terrain_jeu.tterrain[(flottes.tflotte[i].tbateau[x].ligne -1)*10 + flottes.tflotte[i].tbateau[x].colonne]=1 ALORS
				test<-- VRAI
			SINON test<-- FAUX
				i<--i+1
			FIN SI
		FIN TANT QUE
	FIN SI
FIN FONCTION
	



	
		
		
	
	
			
	
			

}	



























Program bataille_navale;
uses crt;



CONST
	N=10;
	MAX=10;




TYPE cell= RECORD

		ligne,colonne: INTEGER;
END;




TYPE bateau=  RECORD

		tbateau:ARRAY[1..MAX] OF cell;
END;




TYPE flotte= RECORD

		tflotte:ARRAY[1..2] OF bateau;
END;




TYPE terrain= RECORD

		tterrain:ARRAY[1..N*N] OF INTEGER;
END;





	procedure creation_terrain ( VAR terrain_jeu:terrain);							//CREATION DU TERRAIN

	VAR
		i: INTEGER;


	BEGIN

		FOR i:=1 TO (N*N) DO
			BEGIN

				IF (i MOD 10)=0 THEN
					writeln (terrain_jeu.tterrain[i])

				ELSE write (terrain_jeu.tterrain[i]);
			END;
	END;






	function comparaison_cellule ( VAR terrain_jeu:terrain; VAR cellule:cell): BOOLEAN;

	VAR
		comparaison: BOOLEAN;

	BEGIN

		IF (terrain_jeu.tterrain[(cellule.ligne-1)*10+cellule.colonne])=1 THEN
			comparaison:= TRUE
		ELSE comparaison:= FALSE;

		comparaison_cellule:=comparaison;
		writeln (comparaison);
		readln;

	END;





	procedure creation_bateau (VAR flottes:flotte; VAR terrain_jeu:terrain);

		VAR

			i,j,p: INTEGER;
			deja_pris, test_cadre: BOOLEAN;

		BEGIN

		writeln ('Vous devez maintenant placer un total de 5 bateaux sur le terrain de jeu. Attention: Chacun de vos bateaux se compose d''une et unique cellule, par consequent ils seront détruits apres seulement un coup.');

			
				i:=1;
				


					FOR j:=1 TO 5 DO
						BEGIN
							REPEAT
								BEGIN
								deja_pris:=TRUE;
								p:=1;



								writeln ('Joueur 1, Choisissez la ligne sur laquelle sera placé le bateau.');
								readln (flottes.tflotte[i].tbateau[j].ligne);
								

									WHILE deja_pris=TRUE AND (p<j)  DO
										BEGIN
												
												IF ((flottes.tflotte[i].tbateau[p].ligne)= (flottes.tflotte[i].tbateau[j].ligne)) THEN
													deja_pris:= FALSE;
													p:=p+1;
													
										END;


									IF (flottes.tflotte[i].tbateau[j].ligne>0) AND (flottes.tflotte[i].tbateau[j].ligne<=10) THEN
										test_cadre:= TRUE
									ELSE test_cadre:= FALSE;




								END;
								UNTIl test_cadre AND deja_pris;



							

							REPEAT
							BEGIN
							deja_pris:= TRUE;
							p:=1;
							

							
							writeln ('Choisissez la colonne sur laquelle sera placé le bateau');
							readln  (flottes.tflotte[i].tbateau[j].colonne);


								WHILE deja_pris=TRUE AND (p<j) DO
									BEGIN
											
											IF ((flottes.tflotte[i].tbateau[p].colonne)=(flottes.tflotte[i].tbateau[j].colonne)) THEN
												deja_pris:= FALSE;
												p:=p+1;
												
									END;

									IF (flottes.tflotte[i].tbateau[j].colonne>0) AND (flottes.tflotte[i].tbateau[j].colonne<=10) THEN
									test_cadre:=TRUE
									ELSE test_cadre:= FALSE;


							END;
							UNTIL test_cadre AND deja_pris;


							terrain_jeu.tterrain[((flottes.tflotte[i].tbateau[j].ligne) -1)*10 + (flottes.tflotte[i].tbateau[j].colonne)]:=1;

					END;









						creation_terrain(terrain_jeu);









				i:=2;
					FOR j:=6 TO 10 DO
						BEGIN
				
							REPEAT
								BEGIN
								deja_pris:=TRUE;
								p:=1;
						
							
								writeln ('Joueur 2, Choisissez la ligne sur laquelle sera placé le bateau.');
								readln (flottes.tflotte[i].tbateau[j].ligne);
							

									WHILE deja_pris=TRUE AND (p<j)   DO
										BEGIN
												
												IF ((flottes.tflotte[i].tbateau[p].ligne)= (flottes.tflotte[i].tbateau[j].ligne)) THEN
													deja_pris:= FALSE;
													p:=p+1;
													
										END;


									IF (flottes.tflotte[i].tbateau[j].ligne>0) AND (flottes.tflotte[i].tbateau[j].ligne<=10) THEN
										test_cadre:= TRUE
									ELSE test_cadre:= FALSE;




							END;
							UNTIl test_cadre AND deja_pris;



							

							REPEAT
								BEGIN
								deja_pris:= TRUE;
								p:=1;

								
								writeln ('Choisissez la colonne sur laquelle sera placé le bateau');
								readln  (flottes.tflotte[i].tbateau[j].colonne);


									WHILE deja_pris=TRUE AND (p<j)   DO
										BEGIN
												
												IF ((flottes.tflotte[i].tbateau[p].colonne)=(flottes.tflotte[i].tbateau[j].colonne)) THEN
													deja_pris:= FALSE;
													p:=p+1;
												
										END;

									IF (flottes.tflotte[i].tbateau[j].colonne>0) AND (flottes.tflotte[i].tbateau[j].colonne<=10) THEN
										test_cadre:=TRUE
									ELSE test_cadre:= FALSE;


								END;
								UNTIL test_cadre AND deja_pris;


							terrain_jeu.tterrain[((flottes.tflotte[i].tbateau[j].ligne) -1)*10 + (flottes.tflotte[i].tbateau[j].colonne)]:=1;


					END;

		END;





		function test_bateau (VAR bateaux:bateau; VAR x: INTEGER):BOOLEAN;

			VAR
				terrain_jeu:terrain;
				cellule:cell;
				test:BOOLEAN;


			BEGIN

				

				comparaison_cellule (terrain_jeu,cellule);



				IF comparaison_cellule(terrain_jeu, cellule) THEN
					BEGIN
						x:=1;

						WHILE test=FALSE DO
							BEGIN
								IF terrain_jeu.tterrain[(bateaux.tbateau[x].ligne -1)*10 + bateaux.tbateau[x].colonne]=1 THEN
									test:= TRUE
								ELSE
									BEGIN
									test:= FALSE;
									x:=x+1;
									END;
							END;
					END;			
	
				test_bateau:=test;
				writeln (test);
				readln;
			END;	



		function test_flotte (VAR terrain_jeu: terrain; VAR flottes: flotte; VAR i: INTEGER): BOOLEAN;

			VAR
			x: INTEGER;
			bateaux:bateau;
			cellule:cell;
			test: BOOLEAN;


			BEGIN

				test_bateau (bateaux,x);


				IF test_bateau (bateaux,x) THEN
					BEGIN
					i:=1;

					WHILE test=FALSE DO
						BEGIN

							IF terrain_jeu.tterrain[(flottes.tflotte[i].tbateau[x].ligne -1)*10 + flottes.tflotte[i].tbateau[x].colonne]=1 THEN
								test:= TRUE
							ELSE
								BEGIN
								test:=FALSE;
								i:=i+1;
								END;
						END;
				END;

			test_flotte:=test;
			writeln (test);
			readln;
			END;





































//PROGRAMME PRINCIPAL

	VAR

		terrain_jeu:terrain;
		flottes:flotte;
		i,x, f,b: INTEGER;
		cellule:cell;
		test_fin1,test_fin2: BOOLEAN;



	BEGIN
	clrscr;
		writeln ('Bienvenue matelot, dans la grande BATAILLE NAVALE. Dans un premier temps, vous allez choisir le placement de vos bateaux. Ensuite, il vous faudra jouer à tour de role et entrer chacun votre tour des coordonees à cibler.' );
		creation_bateau (flottes, terrain_jeu);

	REPEAT

		writeln ('Choisissez la ligne attaquee.');
			readln (cellule.ligne);

		writeln ('Choisissez la colonne attaquee.');
			readln (cellule.colonne);

			test_flotte (terrain_jeu, flottes, i);

			IF test_flotte (terrain_jeu,flottes,i) THEN
				BEGIN
					flottes.tflotte[i].tbateau[x].ligne:=0;
					flottes.tflotte[i].tbateau[x].colonne:=0;
					terrain_jeu.tterrain[((flottes.tflotte[i].tbateau[x].ligne) -1)*10 + (flottes.tflotte[i].tbateau[x].colonne)]:=0;

					writeln ('Touché, Coulé! Vous avez détruit un bateau de la flotte ',i);
				END;

					test_fin1:= FALSE;
					test_fin2:=FALSE;
						FOR b:=1 TO 10 DO
							BEGIN
								IF ((flottes.tflotte[1].tbateau[b].ligne=0) AND (flottes.tflotte[1].tbateau[b].colonne=0)) THEN
									test_fin1:=TRUE;


								IF ((flottes.tflotte[2].tbateau[b].ligne=0) AND (flottes.tflotte[1].tbateau[b].colonne=0)) THEN
									test_fin2:= TRUE;


				END;



	
	UNTIL 	test_fin1=TRUE OR test_fin2=TRUE;


	



	

				IF test_fin1 THEN

					writeln ('Quel dommage, vous avez perdu!');


				IF test_fin2 THEN

					writeln ('Félicitations, vous avez gagné!');




	
	readln;
	END.










