#' ---
#' title: "Untitled"
#' output: html_document
#' ---

#' ## データのインポート
#' RStudio の右上「import Dataset」から From Excel を選ぶ。

#+ include = F
library(readxl)
hsbdemo_kai = read_excel("hsbdemo_kai.xlsx")

#' ## 元データをコピー
d = hsbdemo_kai

#' ## 今回の分析に必要なパッケージのインストール
#' 右側中央にある「install」をクリックし，VGAM と入力して，インストール。または次のコマンドで一発。
#' install.packages("VGAM")

#' ## データを確認
head(d)

#' 今回は，生徒の属する教育プログラム（prog）が，性別（gender）や社会経済地位（ses）からどれほど影響を受けるか知りたいとする。

#' ## データの構造を確認
str(d)

#' ## 文字列を因子化する←何のため？
d$prog = factor(d$prog)
d$gender = as.factor(d$gender)
d$ses = as.factor(d$ses)

#' ## データの概要を再確認
str(d)
summary(d)

#' ## 因子を並び変える
d$prog = factor(d$prog, levels = c("general", "vocation", "academic"))
d$ses = factor(d$ses, levels = c("low", "middle", "high"))


#' ## 思った順番どおりになったか確認
summary(d)

#' ## 多項ロジットモデルによる分析
library(VGAM)
fit = vglm(prog ~ gender + ses, data = d, family = multinomial(refLevel = 1)) 

#' refLevel は1にしておくこと。1番目の factor を基準して計算するため。

#' ## 結果を見る
summary(fit)
