<!-- Start of menubar.tpl -->
<ul class="navbar-nav{if !$theme_config->quicksearch_navbar} ml-auto{/if}">
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            About
        </a>
        <div class="dropdown-menu">
            <a class="dropdown-item" href="/activities/">Activities</a>
            <a class="dropdown-item" href="/calendar/">Calendar</a>
            <a class="dropdown-item" href="/camp-director/">Camp Director</a>
            <a class="dropdown-item" href="/faq/">FAQ</a>
            <a class="dropdown-item" href="/fees-and-dates/">Fees &amp; Dates</a>
            <a class="dropdown-item" href="/food--nutrition/">Food &amp; Nutrition</a>
            <a class="dropdown-item" href="/health-and-safety/">Health &amp; Safety</a>
            <a class="dropdown-item" href="/history/">History</a>
            <a class="dropdown-item" href="/rentals/">Rentals</a>
            <a class="dropdown-item" href="/testimonials/">Testimonials</a>
        </div>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Alumni
        </a>
        <div class="dropdown-menu">
            <a class="dropdown-item" href="/alumni-archive/">Alumni Archive</a>
            <a class="dropdown-item" href="https://facebook.com/campgesher">Reconnect</a>
            <a class="dropdown-item" href="/visiting-camp/">Visiting Camp</a>
        </div>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Contact
        </a>
        <div class="dropdown-menu">
            <a class="dropdown-item" href="/contact-us/">Contact Us</a>
            <a class="dropdown-item" href="/directions/">Directions</a>
            <a class="dropdown-item" href="/write-a-camper/">Write a Camper</a>
        </div>
    </li>
    <li class="nav-item">
        <a href="https://canadahelps.org/en/dn/4502" class="nav-link">Donate</a>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Preparation
        </a>
        <div class="dropdown-menu">
            <a class="dropdown-item" href="/schedule/">Daily Schedule</a>
            <a class="dropdown-item" href="/packing-list/">Packing List</a>
            <a class="dropdown-item" href="/transportation/">Transportation</a>
        </div>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Register
        </a>
        <div class="dropdown-menu">
            <a class="dropdown-item" href="https://jewishtoronto.com/cje/camp">Camp Grant</a>
            <a class="dropdown-item" href="https://gesher.campbrainregistration.com/">Summer Sessions</a>
            <a class="dropdown-item" href="/taste-of-gesher/">Taste of Gesher</a>
        </div>
    </li>
{assign var="discover_menu_exists" value=false}
{foreach from=$blocks key=id item=block}
{if not empty($block->template)}
{if $id != "mbMenu" && $id != "mbSpecials" && $id != "mbIdentification"}
{include file=$block->template|@get_extent:$id }
{/if}
{if $discover_menu_exists == false && ($id == "mbSpecials" or $id == "mbMenu")}
    <li class="nav-item dropdown">                                                                                                                                                   
        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">{'Discover'|@translate}</a>
        <div class="dropdown-menu dropdown-menu-right" role="menu">
        {if not empty($blocks.mbMenu->template)}
        {include file=$blocks.mbMenu->template}
        {/if}
        {if not empty($blocks.mbSpecials->template)}
        {if not empty($blocks.mbMenu->template)}
            <div class="dropdown-divider"></div>
        {/if}
        {include file=$blocks.mbSpecials->template}
        {/if}
        </div>
    </li>
{assign var="discover_menu_exists" value=true}
{/if}
{else}
{$block->raw_content}
{/if}
{/foreach}

{* use foreach again for plugin compatibility, no idea why $blocks.mbIdentification->template breaks SocialConnect, for example *}
{foreach from=$blocks key=id item=block}
{if not empty($block->template) && $id == "mbIdentification"}
{include file=$block->template|@get_extent:$id }
{/if}
{/foreach}
</ul>
<!-- End of menubar.tpl -->
