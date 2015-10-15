<ul class="nav nav-list">
<g:if test="${searchresults}">

    <li>

%{--<li onclick="validation">--}%

    <g:each var="a" in="${searchresults}">
    %{--${a.childs.filter}--}%
    %{--${a.subMenu}--}%
    %{--${session.activeScreen.filter}--}%
    %{--<li class="${session.activeScreen?.id == a.id ? 'active open' : ''}">--}%
        <li class="open">
            <g:link controller="${a.controller}" params="${[scrid: a.id]}" class="dropdown-toggle">
                <i class="icon-desktop"></i>
                <span class="menu-text">${a.subMenu}</span>
                <b class="arrow icon-angle-down"></b>

            </g:link>

            <ul class="submenu">
            %{--<li onclick="validation">--}%
                <g:each var="c" in="${a.childs}">

                    <li class="${session.activeScreen?.id == c.id ? 'active' : ''}">
                        <g:link controller="${c.controller}" params="${[scrid: c.id]}">
                            <i class="icon-double-angle-right"></i>

                            ${c.domainName}
                        </g:link>
                    </li>

                </g:each>

            </ul>

        </li>
    </g:each>
%{--<ul class="nav nav-list">--}%

%{--<li>--}%
%{--<g:each var="c" in="${Screen.findAllByController(null)}">--}%
%{--<li class="${session.activeScreen?.id == c.id ? 'active' : session.activeScreen?.parentScreen?.id == c.id ? 'active open' : ''}">--}%
%{--<g:link controller="${c.controller}" params="[scrid: c.id]" class="dropdown-toggle">--}%

%{--<i class="icon-desktop"></i>--}%
%{--<span class="menu-text">${c.name}</span>--}%
%{--<b class="arrow icon-angle-down"></b>--}%
%{--</g:link>--}%

%{--<ul class="submenu">--}%
%{--<li onclick="validation">--}%
%{--<g:each var="a" in="${Screen.findAllByParentScreen(Screen.findById(c.id))}">--}%
%{--<li class="${session.activeScreen?.id == a.id ? 'active' : ''}">--}%
%{--<g:link controller="${a.controller}" params="${[scrid: a.id]}">--}%
%{--<i class="icon-double-angle-right"></i>--}%
%{--${a.domainName}--}%
%{--</g:link>--}%
%{--</li>--}%
%{--</g:each>--}%

%{--</ul>--}%

%{--</li>--}%
%{--</g:each>--}%
%{--</li>--}%
%{--</ul><!--/.nav-list-->--}%


    </li>

</g:if>

</ul><!--/.nav-list-->