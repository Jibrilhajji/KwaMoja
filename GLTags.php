<?php

include('includes/session.php');
$Title = _('Maintain General Ledger Tags');

$ViewTopic = 'GeneralLedger';
$BookMark = 'GLTags';
include('includes/header.php');

if (isset($_GET['SelectedTag'])) {
	if ($_GET['Action'] == 'delete') {
		//first off test there are no transactions created with this tag
		$Result = DB_query("SELECT counterindex
							FROM gltags
							WHERE tag='" . $_GET['SelectedTag'] . "'");
		if (DB_num_rows($Result) > 0) {
			prnMsg(_('This tag cannot be deleted since there are already general ledger transactions created using it.'), 'error');
		} else {
			$Result = DB_query("DELETE FROM tags WHERE tagref='" . $_GET['SelectedTag'] . "'");
			prnMsg(_('The selected tag has been deleted'), 'success');
		}
		$Description = '';
	} else {
		$SQL = "SELECT tagref,
					tagdescription
				FROM tags
				WHERE tagref='" . $_GET['SelectedTag'] . "'";

		$Result = DB_query($SQL);
		$MyRow = DB_fetch_array($Result);
		$ref = $MyRow['tagref'];
		$Description = $MyRow['tagdescription'];
	}
} else {
	$Description = '';
	$_GET['SelectedTag'] = '';
}

if (isset($_POST['submit'])) {
	$SQL = "INSERT INTO tags values(NULL, '" . $_POST['Description'] . "')";
	$Result = DB_query($SQL);
}

if (isset($_POST['update'])) {
	$SQL = "UPDATE tags SET tagdescription='" . $_POST['Description'] . "'
		WHERE tagref='" . $_POST['reference'] . "'";
	$Result = DB_query($SQL);
}
echo '<p class="page_title_text" >
		<img src="' . $RootPath . '/css/' . $_SESSION['Theme'] . '/images/maintenance.png" title="' . _('Print') . '" alt="' . $Title . '" />' . ' ' . $Title . '
	</p>';

echo '<form method="post" action="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '" id="form">';
echo '<input type="hidden" name="FormID" value="' . $_SESSION['FormID'] . '" />';
echo '<br />
	<table class="selection" summary="' . _('Description of tag') . '">
	<tr>
		<td>' . _('Description') . '</td>
		<td><input type="text" size="30" autofocus="autofocus" required="required" maxlength="30" name="Description" value="' . $Description . '" /></td>
		<td><input type="hidden" name="reference" value="' . $_GET['SelectedTag'] . '" />';

if (isset($_GET['Action']) and $_GET['Action'] == 'edit') {
	echo '<input type="submit" name="update" value="' . _('Update') . '" />';
} else {
	echo '<input type="submit" name="submit" value="' . _('Insert') . '" />';
}

echo '</td>
	</tr>
</table>';
echo '</form>';

echo '<table class="selection" summary="' . _('List of existing tags') . '">
		<tr>
			<th>' . _('Tag ID') . '</th>
			<th>' . _('Description') . '</th>
		</tr>';

$SQL = "SELECT tagref,
			tagdescription
		FROM tags
		ORDER BY tagref";

$Result = DB_query($SQL);

while ($MyRow = DB_fetch_array($Result)) {
	echo '<tr>
			<td>' . $MyRow['tagref'] . '</td>
			<td>' . $MyRow['tagdescription'] . '</td>
			<td><a href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?SelectedTag=' . $MyRow['tagref'] . '&amp;Action=edit">' . _('Edit') . '</a></td>
			<td><a href="' . htmlspecialchars($_SERVER['PHP_SELF'], ENT_QUOTES, 'UTF-8') . '?SelectedTag=' . $MyRow['tagref'] . '&amp;Action=delete" onclick="return MakeConfirm(\'' . _('Are you sure you wish to delete this GL tag?') . '\', \'Confirm Delete\', this);">' . _('Delete') . '</a></td>
		</tr>';
}

echo '</table>';

include('includes/footer.php');

?>