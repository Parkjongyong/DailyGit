package com.app.ildong.common.pagenation;

import javax.servlet.ServletContext;
import org.springframework.web.context.ServletContextAware;

public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

    private ServletContext servletContext;

    public ImagePaginationRenderer() {

    }

    public void initVariables(){
        firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"first\">&nbsp;</a>";
        previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"pre\">&nbsp;</a>";
        currentPageLabel  = "<a class=\"selected\">{0}</a>&#160;";
        otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
        nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"next\">&nbsp;</a>";
        lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"last\">&nbsp;</a>";
    }

    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
        initVariables();
    }
}