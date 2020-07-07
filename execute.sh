git config --global user.name "bot" &&\
git config --global user.email "bot@example.com" &&\
git remote set-url origin https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git &&\
git checkout -b master &&\

REPOSITORIES=`curl "https://api.github.com/users/rnitta/repos?type=owner&sort=pushed&per_page=100"` &&\
STARS=`echo $REPOSITORIES | jq 'reduce .[].stargazers_count as $n (1; .+$n)'` &&\
FORKS=`echo $REPOSITORIES | jq 'reduce .[].forks as $n (1; .+$n)'` &&\
cp ./templates/README.md ./README.md &&\
sed -i "s/{{STARS}}/$STARS/g" ./README.md &&\
sed -i "s/{{FORKS}}/$FORKS/g" ./README.md &&\
sed -i "s/{{DATE}}/`date '+%Y-%m-%d %H:%M:%S'`/g" ./README.md &&\

git add . &&\
git commit -m"update" &&\
git push origin master