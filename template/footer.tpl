        <!-- Start of footer.tpl -->
        <div class="copyright container{if $theme_config->fluid_width}-fluid{/if}">
            <div class="text-center">
{if isset($debug.TIME)}
                {'Page generated in'|@translate} {$debug.TIME} ({$debug.NB_QUERIES} {'SQL queries in'|@translate} {$debug.SQL_TIME}) -
{/if}
                {*
                    Please, do not remove this copyright. If you really want to,
                            contact us on http://piwigo.org to find a solution on how
                            to show the origin of the script...
                *}
                {'Powered by'|@translate}	<a href="{$PHPWG_URL}" class="Piwigo">Piwigo</a>
{$VERSION}

{if isset($footer_elements)}
{foreach from=$footer_elements item=v}
{$v}
{/foreach}
{/if}
            </div>
        </div>
</div>
<footer class="pt-5 d-flex flex-column align-items-center justify-content-around">
	<ul class="social d-flex">
		<li class="mx-3">
			<a href="https://www.facebook.com/campgesher" style="background:#3b5998;" class="rounded-circle text-white">
				<i class="fa fa-fw fa-fw fa-facebook"></i>
			</a>
		</li>
		<li class="mx-3">
			<a href="#" style="background: #55acee;" class="rounded-circle text-white">
				<i class="fa fa-fw fa-twitter"></i>
			</a>
		</li>
		<li class="mx-3">
			<a href="https://www.instagram.com/campgesher" style="background: #a1a1a1;" class="rounded-circle text-white">
				<i class="fa fa-fw fa-instagram"></i>
			</a>
		</li>
	</ul>
	<p style="color: #a1a1a1;">© 2017 Camp Gesher</p>
</footer>
{if isset($debug.QUERIES_LIST)}
        <div id="debug">
{$debug.QUERIES_LIST}
        </div>
{/if}
{if $theme_config->photoswipe && (($BODY_ID == "thePicturePage" && !empty($thumbnails)) || !empty($THUMBNAILS))}
{include file='_photoswipe_div.tpl'}
{/if}

{include file='_plugin_fixes_js.tpl'}

{if preg_match('/^material/', $theme_config->bootstrap_theme)}
{footer_script require='bootstrap'}
 $('body').bootstrapMaterialDesign();
{/footer_script}
{/if}
{get_combined_scripts load='footer'}
</body>
</html>
