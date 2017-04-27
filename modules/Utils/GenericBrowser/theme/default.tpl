{php}
	load_js($this->get_template_vars('theme_dir').'/Utils/GenericBrowser/default.js');
{/php}

<div>

{if (isset($custom_label) && $custom_label) || isset($letter_links) || isset($form_data_search) || isset($expand_collapse)}
<div class="nonselectable clearfix" style="margin-bottom: 20px">
	<div class="pull-left">
			<!-- Custom label -->
			{if (isset($custom_label) && $custom_label)}
				<span {$custom_label_args}>
				{$custom_label}
					<div class="container" id="search-container">
						<div class="row">
								<span class="input-group-btn" id="search-span">
									<button class="btn btn-large btn-primary" type="button" id="search-button"><span class="glyphicon glyphicon-search"></span></button>
								</span>
								<input type="text" class="form-control" placeholder="..." id="search-bar">
						</div>
					</div>
				</span>
			{/if}
			<!-- QuickJump -->
			{*{if isset($letter_links)}*}
				{*<div class="letters" style="display: inline-block">*}
					{*<button class="btn btn-warning" onclick="quick_jump_letters('{$id}');">ABC</button>*}
					{*<div id="quick_jump_letters_{$id}" class="quick_jump_letters"*}
						{*{if $quickjump_to==''}*}
							{*style="display: none;"*}
						{*{/if}*}
						{*>*}
						{*<div class="css3_content_shadow GenericBrowser_letters">*}
								{*{if isset($letter_links)}*}
								{*{foreach key=k item=letter from=$letter_links}*}
									{*<a class="badge" {$letter.href}>{$letter.label}</a>*}
								{*{/foreach}*}
								{*{/if}*}
						{*</div>*}
					{*</div>*}
				{*</div>*}
			{*{/if}*}
            <!-- Expand/Collapse -->
			{*<div class="expand_collapse" style="display: inline-block">*}
				{*{if isset($expand_collapse)}*}
					{*<a id="{$expand_collapse.e_id}" class="btn btn-success" {$expand_collapse.e_href}><i class="fa fa-caret-square-o-down"></i> {$expand_collapse.e_label} </a>*}
					{*<a id="{$expand_collapse.c_id}" class="btn btn-success" {$expand_collapse.c_href}><i class="fa fa-caret-square-o-up"></i> {$expand_collapse.c_label} </a>*}
				{*{/if}*}
			{*</div>*}
	</div>
	<div class="pull-right">
			<!-- Advanced / Simple Search -->
			{if isset($form_data_search)}
				<div class="form-inline">
					{$form_data_search.javascript}

					<form {$form_data_search.attributes}>
					{$form_data_search.hidden}
					{$search_fields_hidden}
					{if isset($form_data_search.search)}
						{$adv_search}
						{$form_data_search.submit_search.html}
						{$form_data_search.search.html}
						{if isset($form_data_search.show_all)}
							{$form_data_search.show_all.html}
						{/if}
					{else}
						{php}
							$cols = $this->get_template_vars('cols');
							$search_fields = $this->get_template_vars('search_fields');
							foreach($cols as $k=>$v){
								if(isset($search_fields[$k]))
									$cols[$k]['label'] = $cols[$k]['label'].$search_fields[$k];
							}
							$this->assign('cols',$cols);
						{/php}
						{if isset($form_data_search.submit_search)}
							{$adv_search}
							{$form_data_search.submit_search.html}
							{if isset($form_data_search.show_all)}
								{$form_data_search.show_all.html}
							{/if}
						{/if}
					{/if}
					</form>
				</div>
			{/if}
	</div>
</div>
{/if}

{php}
	$cols = $this->get_template_vars('cols');
	foreach($cols as $k=>$v)
		$cols[$k]['label'] = '<span>'.$cols[$k]['label'].'</span>';
	$this->assign('cols',$cols);
{/php}

				{$table_prefix}
				<div class="Utils_GenericBrowser_overflow_container" id="yolo">
                {capture name="table_attr"}id="{$table_id}" cols_width_id="{$cols_width_id}" class="Utils_GenericBrowser table table-bordered table-hover" cellspacing="0" cellpadding="0" style="width:100%;table-layout:fixed;text-overflow:ellipsis;"{/capture}
								{html_table_epesi table_attr=$smarty.capture.table_attr loop=$data cols=$cols row_attrs=$row_attrs}
				</div>
				{$table_postfix}

				{if isset($form_data_paging)}
				{$form_data_paging.javascript}

				<form {$form_data_paging.attributes}>
				{$form_data_paging.hidden}
				{/if}
				{if isset($order) || $first || $prev || $summary || isset($form_data_paging.page) || isset($form_data_paging.per_page)}
						<div class="well well-sm">
							<div class="col-sm-2" style="text-align: left; white-space: nowrap;">
								{if isset($order)}
									{$order}&nbsp;&nbsp;&nbsp;<b>{$reset}</b>&nbsp;&nbsp;&nbsp;
								{/if}
							</div>
							{if isset($__link.first.open) || isset($__link.last.open)}
								{if isset($__link.first.open)}{$__link.first.open}<button class="btn btn-primary"><i class="fa fa-fast-backward"></i> {$__link.first.text}</button>{$__link.first.close}{/if}
								{if isset($__link.prev.open)}{$__link.prev.open}<button class="btn btn-primary"><i class="fa fa-backward"></i> {$__link.prev.text}</button>{$__link.prev.close}{/if}
							{/if}
							<div class="nav_summary col-sm-6" nowrap>&nbsp;&nbsp;&nbsp;{$summary}&nbsp;&nbsp;&nbsp;</div>
							{if isset($__link.first.open) || isset($__link.last.open)}
								{if isset($__link.next.open)}{$__link.next.open}<button class="btn btn-primary"><i class="fa fa-forward"></i> {$__link.next.text}</button>{$__link.next.close}{/if}
								{if isset($__link.last.open)}{$__link.last.open}<button class="btn btn-primary"><i class="fa fa-fast-forward"></i> {$__link.last.text}</button>{$__link.last.close}{/if}
							{/if}
							<div class="nav_pagin col-sm-2" nowrap style="text-align: right; white-space: nowrap;">
								{if isset($form_data_paging.page)}
									{$form_data_paging.page.label} {$form_data_paging.page.html}
								{/if}
							</div>
							<div class="nav_per_page col-sm-2" nowrap style="text-align: right; white-space: nowrap;">
								{if isset($form_data_paging.per_page)}
									{$form_data_paging.per_page.label} {$form_data_paging.per_page.html}
								{/if}
							</div>
							<div class="clearfix"></div>
						</div>
				{/if}

				{if isset($form_data_paging)}
				</form>
				{/if}

</div>
