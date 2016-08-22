#command helpPHP          "PHPヘルプ"
#command helpPEAR         "PEARヘルプ"
#command cleanEmptyLine   "空行一括削除"
#command addIFExist       "IF EXISTS追加"
#command convPHPShortTag  "PHPショートタグ変換"
#command convDOM          "DOMさんHTML変換"
#command cleanSpaceOfTail "行末スペース削除"
#command convSpaceLine    "スペース行変換"
#command convKBTAppli     "KBTアプリ開発変換"
#command convPOSTVariable "POST変数に"
#command convGETVariable  "GET変数に"
#command PHPHTMLSpecialChars  "PHPタグ(htmlspecialchars)"
#command PHPNumberFormat  "PHPタグ(number_format)"
#command convTab2Space  "タブを4スペースに"

var PHP_MANUAL_BASE_URL = "http://jp2.php.net/search.php?lang=ja&show=quickref&pattern=";
var PEAR_MANUAL_BASE_URL = "http://pear.php.net/search.php?in=packages&q=";

// 選択範囲の文字列
var text = getSelectedText().trim();

switch (command) {
	case "helpPHP":
		// ブラウザを起動する。
		shellExecute(
			null,
			PHP_MANUAL_BASE_URL + text
		);
	break;
	case "helpPEAR":
		// ブラウザを起動する。
		shellExecute(
			null,
			PEAR_MANUAL_BASE_URL + text
		);
	break;
	case "cleanEmptyLine":
		enterUndoGroup();
		var no = 1;
		var reg = /^$/;
		var p = new Point();
		while (getLineCount() > no) {
			if (reg.test(getLine(no))) {
				p.line = no;
				gotoPoint(p);
				deleteLine();
			} else {
				no++;
			}
		}
		leaveUndoGroup();
	break;
	case "addIFExist":
		enterUndoGroup();
		replace(/DROP TABLE/ig, "DROP TABLE IF EXISTS");
		replace(/DROP DATABASE/ig, "DROP DATABASE IF EXISTS");
		leaveUndoGroup();
	break;
	case "convPHPShortTag":
		enterUndoGroup();
		replace(/<\?=/ig, "<?php echo");
		replace(/<\? /ig, "<?php ");
		replace(/<\?$/ig, "<?php");
		leaveUndoGroup();
	break;
	case "convDOM":
		enterUndoGroup();
		replace(/src="[^'"]+\/img\//g, "src=\"/img/");
		replace(/href="[^'"]+\/css\//g, "href=\"/css/");
		replace(/heiht\:/g, "height:");
		leaveUndoGroup();
	break;
	case "cleanSpaceOfTail":
		enterUndoGroup();
		replace(/\s+$/g, "");
		leaveUndoGroup();
	break;
	case "convSpaceLine":
		enterUndoGroup();
		replace(/^(\s|\t)+$/g, "");
		leaveUndoGroup();
	break;
	case "convKBTAppli":
		enterUndoGroup();
		replace(/\$_POST\[\"([a-zA-Z0-9_]+)\"\]/g, "$$$1");
		replace(/\$errors\[[^\]]+\]/g, "$$errors[]");
		leaveUndoGroup();
	break;
	case "convPOSTVariable":
		enterUndoGroup();
		var _p1 = getSelection();
		replaceTextBetween(
			_p1[0],
			_p1[1],
			getSelectedText().replace(/\$([a-zA-Z0-9_]+)/g, "@$$_POST[\"$1\"]")
		);
		leaveUndoGroup();
	break;
	case "convGETVariable":
		enterUndoGroup();
		var _p2 = getSelection();
		replaceTextBetween(
			_p2[0],
			_p2[1],
			getSelectedText().replace(/\$([a-zA-Z0-9_]+)/g, "@$$_GET[\"$1\"]")
		);
		leaveUndoGroup();
	break;
	case "PHPHTMLSpecialChars":
		enterUndoGroup();
		var _p3 = getSelection();
		replaceTextBetween(
			_p3[0],
			_p3[1],
			"<?php echo htmlspecialchars(" + getSelectedText() + ") ?>"
		);
		leaveUndoGroup();
	break;
	case "PHPNumberFormat":
		enterUndoGroup();
		var _p4 = getSelection();
		replaceTextBetween(
			_p4[0],
			_p4[1],
			"<?php echo number_format(" + getSelectedText() + ") ?>"
		);
		leaveUndoGroup();
	break;
	case "convTab2Space":
		enterUndoGroup();
		replace(/\t/g, "    ");
		leaveUndoGroup();
	break;
	default:
		error("不明コマンド: " + command);
}
