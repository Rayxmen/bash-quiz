#!/bin/bash

# ==========================
#        QUIZ BASH
# ==========================

score=0
total=0

clear
echo "=========================="
echo "     🧠 QUIZ BASH 🧠"
echo "=========================="
echo "Score maximum : 20"
echo ""
echo "1) Démarrer le quiz"
echo "2) Quitter"
echo ""
read -p "Ton choix : " choice < /dev/tty

if [ "$choice" != "1" ]; then
    echo "À bientôt 👋"
    exit 0
fi

clear
echo "Le quiz commence ! Bonne chance 🍀"
echo ""

# Lecture des questions depuis le fichier
while IFS="|" read -r question answer
do
    # Ignore les lignes vides
    [ -z "$question" ] && continue

    total=$((total + 1))

    echo "Question $total / 20"
    echo "$question"
    read -p "Ta réponse : " user_answer < /dev/tty

    # Nettoyage des réponses (majuscules, espaces, Windows CRLF)
    user_answer=$(echo "$user_answer" | tr '[:upper:]' '[:lower:]' | xargs)
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]' | tr -d '\r' | xargs)

    if [ "$user_answer" = "$answer" ]; then
        echo "✅ Bonne réponse !"
        score=$((score + 1))
    else
        echo "❌ Faux. Réponse : $answer"
    fi

    echo "--------------------------"

    # Stop à 20 questions
    [ "$total" -eq 20 ] && break

done < questions.txt

# Résultat final
echo ""
echo "=========================="
echo " 🎯 SCORE FINAL : $score / 20"
echo "=========================="

# Message selon le score
if [ "$score" -ge 16 ]; then
    echo "🔥 Excellent ! Tu maîtrises Bash !"
elif [ "$score" -ge 10 ]; then
    echo "👍 Bien joué ! Encore un peu d'entraînement."
else
    echo "📘 Continue à t'entraîner, tu progresses !"
fi
