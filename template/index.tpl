<!-- Start of index.tpl -->
{combine_script id='cookie' require='jquery' path='themes/bootstrap_darkroom/js/jquery.cookie.js' load='footer'}
{combine_script id='equalheights' require='jquery' path='themes/bootstrap_darkroom/js/jquery.equalheights.js' load='footer'}
{if get_device() != 'desktop'}
{combine_script id='jquery.mobile-events' path='themes/bootstrap_darkroom/js/jquery.mobile-events.min.js' require='jquery' load='footer'}
{/if}
{if !empty($PLUGIN_INDEX_CONTENT_BEFORE)}{$PLUGIN_INDEX_CONTENT_BEFORE}{/if}

{include file='infos_errors.tpl'}

<div class="container{if $theme_config->fluid_width}-fluid{/if}">
{if !empty($PLUGIN_INDEX_CONTENT_BEGIN)}{$PLUGIN_INDEX_CONTENT_BEGIN}{/if}

{if isset($chronology_views)}
    <div id="calendar-select" class="btn-group">
        <button id="calendar-view" type="button" class="btn btn-primary btn-raised dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            {foreach from=$chronology_views item=view}{if $view.SELECTED}{$view.CONTENT}{/if}{/foreach}
        </button>
        <div class="dropdown-menu" aria-labelledby="calendar-view">
            {foreach from=$chronology_views item=view name=loop}
                <a class="dropdown-item {if $view.SELECTED} active{/if}" href="{$view.VALUE}">{$view.CONTENT}</a>
            {/foreach}
        </div>
    </div>
{/if}

{if isset($FILE_CHRONOLOGY_VIEW)}
    {include file=$FILE_CHRONOLOGY_VIEW}
{/if}

{if !empty($CONTENT_DESCRIPTION)}
    <div id="content-description" class="py-3{if $theme_config->thumbnail_cat_desc == 'simple'} text-center{/if}">
{if $theme_config->thumbnail_cat_desc == 'simple'}
        <h5>{$CONTENT_DESCRIPTION}</h5>
{else}
        {$CONTENT_DESCRIPTION}
{/if}
    </div>
{/if}
    <div id="content" class="{if $smarty.cookies.view == 'list'}content-list{else}content-grid{/if}{if empty($CONTENT_DESCRIPTION)} pt-3{/if}">
{if !empty($CONTENT)}
    <!-- Start of content -->
    {$CONTENT}
    <!-- End of content -->
{/if}

{if !empty($CATEGORIES)}
    <!-- Start of categories -->
{$CATEGORIES}
{footer_script require='jquery'}{strip}
$(document).ready(function() {
  $('#content .col-outer .card-body').equalHeights();
});
{/strip}{/footer_script}
    <!-- End of categories -->
{/if}

{if !empty($THUMBNAILS)}
        <!-- Start of thumbnails -->
        <div id="thumbnails" class="row">{$THUMBNAILS}</div>
{footer_script require='jquery'}{literal}$(document).ready(function(){$('#content img').load(function(){$('#content .col-inner').equalHeights()})});{/literal}{/footer_script}
{if $theme_config->photoswipe}
        <div id="photoSwipeData">
{assign var=idx value=0}
{foreach from=$thumbnails item=thumbnail}
{assign var=derivative_medium value=$pwg->derivative($derivative_params_medium, $thumbnail.src_image)}
{assign var=derivative_large value=$pwg->derivative($derivative_params_large, $thumbnail.src_image)}
{assign var=derivative_xxlarge value=$pwg->derivative($derivative_params_xxlarge, $thumbnail.src_image)}
            <a href="{$thumbnail.URL}" data-index="{$idx}" data-name="{$thumbnail.NAME}" data-description="{$thumbnail.DESCRIPTION}" data-src-medium="{$derivative_medium->get_url()}" data-size-medium="{$derivative_medium->get_size_hr()}" data-src-large="{$derivative_large->get_url()}" data-size-large="{$derivative_large->get_size_hr()}" data-src-xlarge="{$derivative_xxlarge->get_url()}" data-size-xlarge="{$derivative_xxlarge->get_size_hr()}"{if preg_match("/(mp4|m4v)$/", $thumbnail.PATH)} data-src-original="{$U_HOME}{$thumbnail.PATH}" data-size-original="{$thumbnail.SIZE}" data-video="true"{else}{if $theme_config->photoswipe_metadata} data-exif-make="{$thumbnail.EXIF.make}" data-exif-model="{$thumbnail.EXIF.model}" data-exif-lens="{$thumbnail.EXIF.lens}" data-exif-iso="{$thumbnail.EXIF.iso}" data-exif-apperture="{$thumbnail.EXIF.apperture}" data-exif-shutter-speed="{$thumbnail.EXIF.shutter_speed}" data-exif-focal-length="{$thumbnail.EXIF.focal_length}" data-date-created="{$thumbnail.DATE_CREATED}"{/if}{/if}></a>
{assign var=idx value=$idx+1}
{/foreach}
{include file='_photoswipe_js.tpl' selector='#photoSwipeData'}
        </div>
{footer_script require='jquery' require='photoswipe'}{strip}
$('#startSlideshow').on('click touchstart', function() {
   startPhotoSwipe(0);
   $('.pswp__button--autoplay')[0].click();
});

function setupPhotoSwipe() {
   $('#thumbnails').find("a:has(img):not(.addCollection)").each(function(_index) {
      var $pswpIndex;
      if ($(this).find('img').length > 0) {
         var _href = $(this).href;
         $(this).attr('href', 'javascript:;').attr('data-href', _href);
         if (!$(this).attr('data-index')) {
            $(this).attr('data-index', _index);
            $pswpIndex = _index;
         } else {
            $pswpIndex = $(this).data('index');
         }
         $(this).off('click tap').on('click tap', function(event) {
            event.preventDefault();
            startPhotoSwipe($pswpIndex);
         });
      }
   });
}

{if $theme_config->thumbnail_linkto == 'photoswipe' || ($theme_config->thumbnail_linkto == 'photoswipe_mobile_only' && get_device() != 'desktop')}
$(document).ready(function() {
   setupPhotoSwipe();
});

{if isset($loaded_plugins['rv_tscroller'])}
$(document).ajaxComplete(function() {
   setupPhotoSwipe();
});
{/if}
{/if}
{/strip}{/footer_script}
{/if}
{footer_script require="jquery"}{strip}
{if !isset($loaded_plugins['piwigo-videojs']) && (isset($GThumb) || isset($GDThumb))}
function addVideoIndicator() {
  $('img.thumbnail[src*="pwg_representative"]').each(function() {
    $(this).closest('li').append('<i class="fa fa-file-video-o fa-2x video-indicator" aria-hidden="true" style="position: absolute; top: 10px; left: 10px; z-index: 100; color: #fff;"></i>');
  });
}
$(document).ready(function() {
  addVideoIndicator();
});
$(document).ajaxComplete(function() {
  addVideoIndicator();
});
{else}
$('.col-thumbnail').find('img[src*="pwg_representative"]').each(function() {
  $(this).closest('div').append('<i class="fa fa-file-video-o fa-2x video-indicator" aria-hidden="true" style="position: absolute; top: 15px; left: 30px; z-index: 100; color: #fff;"></i>');
});
{/if}
{/strip}{/footer_script}
        <!-- End of thumbnails -->
{/if}
    </div>
</div>
{if !empty($cats_navbar) || !empty($thumb_navbar)}
<div class="container{if $theme_config->fluid_width}-fluid{/if}">
{if !empty($cats_navbar)}
    {include file='navigation_bar.tpl' fragment="content"|@get_extent:'navbar' navbar=$cats_navbar}
{/if}
{if !empty($thumb_navbar) && !isset($loaded_plugins['rv_tscroller'])}
    {include file='navigation_bar.tpl' fragment="content"|@get_extent:'navbar' navbar=$thumb_navbar}
{/if}
</div>
{/if}

{if !empty($category_search_results)}
<div class="container{if $theme_config->fluid_width}-fluid{/if}">
    <h3 class="category_search_results">{'Album results for'|@translate} <em><strong>{$QUERY_SEARCH}</strong></em></h3>
    <p>
        <em><strong>
{foreach from=$category_search_results item=res name=res_loop}
{if !$smarty.foreach.res_loop.first} &mdash; {/if}
            {$res}
{/foreach}
        </strong></em>
    </p>
</div>
{/if}

{if !empty($tag_search_results)}
<div class="container{if $theme_config->fluid_width}-fluid{/if}">
    <h3 class="tag_search_results">{'Tag results for'|@translate} <em><strong>{$QUERY_SEARCH}</strong></em></h3>
    <p>
        <em><strong>
{foreach from=$tag_search_results item=tag name=res_loop}
{if !$smarty.foreach.res_loop.first} &mdash; {/if}
            <a href="{$tag.URL}">{$tag.name}</a>
{/foreach}
        </strong></em>
    </p>
</div>
{/if}

<div class="container{if $theme_config->fluid_width}-fluid{/if}">
{if !empty($PLUGIN_INDEX_CONTENT_END)}{$PLUGIN_INDEX_CONTENT_END}{/if}
</div>

{if !empty($PLUGIN_INDEX_CONTENT_AFTER)}{$PLUGIN_INDEX_CONTENT_AFTER}{/if}
<!-- End of index.tpl -->
