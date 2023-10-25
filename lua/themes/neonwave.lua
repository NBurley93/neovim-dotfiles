local Color, colors, Group, groups, styles = require("colorbuddy").setup()

return {
	use = function()
		Color.new("BooleanFG", "#00d7ff")
		Group.new("Boolean", colors.BooleanFG, colors.NONE, styles.NONE)

		Color.new("CursorFG", "#080808")
		Color.new("CursorBG", "#6c6c6c")
		Group.new("Cursor", colors.CursorFG, colors.CursorBG, styles.NONE)

		Color.new("ConstantFG", "#0087ff")
		Group.new("Constant", colors.ConstantFG, colors.NONE, styles.NONE)

		Color.new("CharacterFG", "#ff5fff")
		Group.new("Character", colors.CharacterFG, colors.NONE, styles.NONE)

		Color.new("ConditionalFG", "#ff00ff")
		Group.new("Conditional", colors.ConditionalFG, colors.NONE, styles.NONE)

		Color.new("CommentFG", "#808080")
		Group.new("Comment", colors.CommentFG, colors.NONE, styles.NONE)

		Color.new("CursorLineBG", "#262626")
		Group.new("CursorLine", colors.NONE, colors.CursorLineBG, styles.NONE)

		Color.new("cursorcolumnBG", "#262626")
		Group.new("cursorcolumn", colors.NONE, colors.NONE, styles.NONE)

		Color.new("CursorLineNrFG", "#00d7ff")
		Color.new("CursorLineNrBG", "#262626")
		Group.new("CursorLineNr", colors.CursorLineNrFG, colors.CursorLineNrBG, styles.NONE)

		Color.new("DefineFG", "#5f5faf")
		Group.new("Define", colors.DefineFG, colors.NONE, styles.NONE)

		Color.new("DefinedNameFG", "#ff00d7")
		Group.new("DefinedName", colors.DefinedNameFG, colors.NONE, styles.NONE)

		Color.new("DelimiterFG", "#ff5fff")
		Group.new("Delimiter", colors.DelimiterFG, colors.NONE, styles.NONE)

		Color.new("DirectoryFG", "#00d7ff")
		Group.new("Directory", colors.DirectoryFG, colors.NONE, styles.NONE)

		Color.new("ErrorFG", "#ff0000")
		Color.new("ErrorBG", "#080808")
		Group.new("Error", colors.ErrorFG, colors.ErrorBG, styles.NONE)

		Color.new("ErrorMsgFG", "#ff0000")
		Color.new("ErrorMsgBG", "#080808")
		Group.new("ErrorMsg", colors.ErrorMsgFG, colors.ErrorMsgBG, styles.NONE)

		Color.new("ExceptionFG", "#ff00ff")
		Group.new("Exception", colors.ExceptionFG, colors.NONE, styles.NONE)

		Color.new("FloatFG", "#00afaf")
		Group.new("Float", colors.FloatFG, colors.NONE, styles.NONE)

		Color.new("FoldColumnFG", "#0087ff")
		Color.new("FoldColumnBG", "#121212")
		Group.new("FoldColumn", colors.FoldColumnFG, colors.NONE, styles.NONE)

		Color.new("FoldedFG", "#0087ff")
		Group.new("Folded", colors.FoldedFG, colors.NONE, styles.NONE)

		Color.new("FunctionFG", "#00afd7")
		Group.new("Function", colors.FunctionFG, colors.NONE, styles.NONE)

		Color.new("IdentifierFG", "#ff00ff")
		Group.new("Identifier", colors.IdentifierFG, colors.NONE, styles.NONE)

		Color.new("IncludeFG", "#5f87ff")
		Group.new("Include", colors.IncludeFG, colors.NONE, styles.NONE)

		Color.new("IncSearchFG", "#080808")
		Color.new("IncSearchBG", "#0087ff")
		Group.new("IncSearch", colors.IncSearchFG, colors.IncSearchBG, styles.NONE)

		Color.new("jsonKeywordFG", "#00d7ff")
		Group.new("jsonKeyword", colors.jsonKeywordFG, colors.NONE, styles.NONE)

		Color.new("KeywordFG", "#ff00ff")
		Group.new("Keyword", colors.KeywordFG, colors.NONE, styles.NONE)

		Color.new("LabelFG", "#ff00ff")
		Group.new("Label", colors.LabelFG, colors.NONE, styles.NONE)

		Color.new("LineNrFG", "#00af87")
		Color.new("LineNrBG", "#121212")
		Group.new("LineNr", colors.LineNrFG, colors.NONE, styles.NONE)

		Color.new("MacroFG", "#5f87ff")
		Group.new("Macro", colors.MacroFG, colors.NONE, styles.NONE)

		Color.new("MatchParenFG", "#00ffd7")
		Color.new("MatchParenBG", "#00afff")
		Group.new("MatchParen", colors.MatchParenFG, colors.MatchParenBG, styles.NONE)

		Color.new("ModeMsgFG", "#00afff")
		Color.new("ModeMsgBG", "#080808")
		Group.new("ModeMsg", colors.ModeMsgFG, colors.ModeMsgBG, styles.NONE)

		Color.new("MoreMsgFG", "#00ff00")
		Group.new("MoreMsg", colors.MoreMsgFG, colors.NONE, styles.NONE)

		Color.new("NonTextFG", "#ff00ff")
		Group.new("NonText", colors.NonTextFG, colors.NONE, styles.NONE)

		Color.new("NormalFG", "#8787ff")
		Color.new("NormalBG", "#1c1c1c")
		Group.new("Normal", colors.NormalFG, colors.NONE, styles.NONE)

		Color.new("NumberFG", "#0087af")
		Group.new("Number", colors.NumberFG, colors.NONE, styles.NONE)

		Color.new("OperatorFG", "#00afff")
		Group.new("Operator", colors.OperatorFG, colors.NONE, styles.NONE)

		Color.new("OverLengthFG", "#00ff00")
		Color.new("OverLengthBG", "#1c1c1c")
		Group.new("OverLength", colors.OverLengthFG, colors.OverLengthBG, styles.NONE)

		Color.new("perlIdentifierFG", "#00afff")
		Group.new("perlIdentifier", colors.perlIdentifierFG, colors.NONE, styles.NONE)

		Color.new("perlNumberFG", "#008787")
		Group.new("perlNumber", colors.perlNumberFG, colors.NONE, styles.NONE)

		Color.new("perlOperatorFG", "#00d7ff")
		Group.new("perlOperator", colors.perlOperatorFG, colors.NONE, styles.NONE)

		Color.new("PMenuFG", "#00af87")
		Color.new("PMenuBG", "#121212")
		Group.new("PMenu", colors.PMenuFG, colors.PMenuBG, styles.NONE)

		Color.new("PMenuSelFG", "#5fafff")
		Color.new("PMenuSelBG", "#262626")
		Group.new("PMenuSel", colors.PMenuSelFG, colors.PMenuSelBG, styles.NONE)

		Color.new("PMenuSbarBG", "#080808")
		Group.new("PMenuSbar", colors.NONE, colors.PMenuSbarBG, styles.NONE)

		Color.new("PMenuThumbBG", "#3a3a3a")
		Group.new("PMenuThumb", colors.NONE, colors.PMenuThumbBG, styles.NONE)

		Color.new("PreConditFG", "#ff00ff")
		Group.new("PreCondit", colors.PreConditFG, colors.NONE, styles.NONE)

		Color.new("PreProcFG", "#5f5fff")
		Group.new("PreProc", colors.PreProcFG, colors.NONE, styles.NONE)

		Color.new("pythonFunctionFG", "#00afd7")
		Group.new("pythonFunction", colors.pythonFunctionFG, colors.NONE, styles.NONE)

		Color.new("pythonExceptionFG", "#ff0000")
		Color.new("pythonExceptionBG", "#080808")
		Group.new("pythonException", colors.pythonExceptionFG, colors.pythonExceptionBG, styles.NONE)

		Color.new("pythonEscapeFG", "#ff00ff")
		Group.new("pythonEscape", colors.pythonEscapeFG, colors.NONE, styles.NONE)

		Color.new("pythonStatementFG", "#00d7ff")
		Group.new("pythonStatement", colors.pythonStatementFG, colors.NONE, styles.NONE)

		Color.new("QuestionFG", "#00ff00")
		Color.new("QuestionBG", "#080808")
		Group.new("Question", colors.QuestionFG, colors.QuestionBG, styles.NONE)

		Color.new("RepeatFG", "#ff00ff")
		Group.new("Repeat", colors.RepeatFG, colors.NONE, styles.NONE)

		Color.new("SearchFG", "#080808")
		Color.new("SearchBG", "#0087ff")
		Group.new("Search", colors.SearchFG, colors.SearchBG, styles.NONE)

		Color.new("shDerefFG", "#5f87ff")
		Group.new("shDeref", colors.shDerefFG, colors.NONE, styles.NONE)

		Color.new("shDerefDelimFG", "#d75fff")
		Group.new("shDerefDelim", colors.shDerefDelimFG, colors.NONE, styles.NONE)

		Color.new("shDerefOpFG", "#ff5fff")
		Group.new("shDerefOp", colors.shDerefOpFG, colors.NONE, styles.NONE)

		Color.new("shDerefVarFG", "#5f87ff")
		Group.new("shDerefVar", colors.shDerefVarFG, colors.NONE, styles.NONE)

		Color.new("shHereDocFG", "#ff5faf")
		Group.new("shHereDoc", colors.shHereDocFG, colors.NONE, styles.NONE)

		Color.new("shOperatorFG", "#d75fff")
		Group.new("shOperator", colors.shOperatorFG, colors.NONE, styles.NONE)

		Color.new("shShellVariablesFG", "#ff5fff")
		Group.new("shShellVariables", colors.shShellVariablesFG, colors.NONE, styles.NONE)

		Color.new("shSnglCaseFG", "#ff00ff")
		Group.new("shSnglCase", colors.shSnglCaseFG, colors.NONE, styles.NONE)

		Color.new("shTestOprFG", "#00afff")
		Group.new("shTestOpr", colors.shTestOprFG, colors.NONE, styles.NONE)

		Color.new("shVariableFG", "#00d7ff")
		Group.new("shVariable", colors.shVariableFG, colors.NONE, styles.NONE)

		Color.new("SignColumnFG", "#00ff00")
		Color.new("SignColumnBG", "#1c1c1c")
		Group.new("SignColumn", colors.SignColumnFG, colors.NONE, styles.NONE)

		Color.new("SpecialFG", "#ff00ff")
		Group.new("Special", colors.SpecialFG, colors.NONE, styles.NONE)

		Color.new("SpecialCharFG", "#d700ff")
		Group.new("SpecialChar", colors.SpecialCharFG, colors.NONE, styles.NONE)

		Color.new("SpecialCommentFG", "#ffffff")
		Group.new("SpecialComment", colors.SpecialCommentFG, colors.NONE, styles.NONE)

		Color.new("SpecialKeyFG", "#8787ff")
		Group.new("SpecialKey", colors.SpecialKeyFG, colors.NONE, styles.NONE)

		Color.new("SpellBadFG", "#ff0000")
		Color.new("SpellBadBG", "#080808")
		Group.new("SpellBad", colors.SpellBadFG, colors.SpellBadBG, styles.NONE)

		Color.new("StatusLineFG", "#0087d7")
		Color.new("StatusLineBG", "#080808")
		Group.new("StatusLine", colors.StatusLineFG, colors.StatusLineBG, styles.NONE)

		Color.new("StatusLineNCFG", "#8787ff")
		Color.new("StatusLineNCBG", "#303030")
		Group.new("StatusLineNC", colors.StatusLineNCFG, colors.NONE, styles.NONE)

		Color.new("StatementFG", "#ff00ff")
		Group.new("Statement", colors.StatementFG, colors.NONE, styles.NONE)

		Color.new("StorageClassFG", "#00d7ff")
		Group.new("StorageClass", colors.StorageClassFG, colors.NONE, styles.NONE)

		Color.new("StringFG", "#d75fff")
		Group.new("String", colors.StringFG, colors.NONE, styles.NONE)

		Color.new("StructureFG", "#00d7ff")
		Group.new("Structure", colors.StructureFG, colors.NONE, styles.NONE)

		Color.new("TabLineFG", "#8787ff")
		Color.new("TabLineBG", "#1c1c1c")
		Group.new("TabLine", colors.TabLineFG, colors.TabLineBG, styles.NONE)

		Color.new("TabLineFillFG", "#8787ff")
		Color.new("TabLineFillBG", "#303030")
		Group.new("TabLineFill", colors.TabLineFillFG, colors.TabLineFillBG, styles.NONE)

		Color.new("TabLineSelFG", "#0087d7")
		Color.new("TabLineSelBG", "#121212")
		Group.new("TabLineSel", colors.TabLineSelFG, colors.TabLineSelBG, styles.NONE)

		Color.new("TitleFG", "#ff00ff")
		Group.new("Title", colors.TitleFG, colors.NONE, styles.NONE)

		Color.new("TodoFG", "#ffffff")
		Color.new("TodoBG", "#ff00ff")
		Group.new("Todo", colors.TodoFG, colors.TodoBG, styles.NONE)

		Color.new("TypeFG", "#00d7ff")
		Group.new("Type", colors.TypeFG, colors.NONE, styles.NONE)

		Color.new("TypedefFG", "#00d7ff")
		Group.new("Typedef", colors.TypedefFG, colors.NONE, styles.NONE)

		Color.new("UnderlinedFG", "#5f87ff")
		Group.new("Underlined", colors.UnderlinedFG, colors.NONE, styles.NONE)

		Color.new("VertSplitFG", "#8787ff")
		Color.new("VertSplitBG", "#303030")
		Group.new("VertSplit", colors.VertSplitFG, colors.NONE, styles.NONE)

		Color.new("VisualFG", "#87afff")
		Color.new("VisualBG", "#3a3a3a")
		Group.new("Visual", colors.VisualFG, colors.VisualBG, styles.NONE)

		Color.new("WarningMsgFG", "#e4e4e4")
		Color.new("WarningMsgBG", "#800000")
		Group.new("WarningMsg", colors.WarningMsgFG, colors.WarningMsgBG, styles.NONE)

		Group.new("GitSignsAdd", colors.WarningMsgFG, colors.NONE, styles.NONE)
		Group.new("GitSignsChange", colors.FoldColumnFG, colors.NONE, styles.NONE)
		Group.new("GitSignsDelete", colors.ErrorFG, colors.NONE, styles.NONE)
	end,
}
