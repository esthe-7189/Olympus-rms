# by neodal #
JSP_PACKAGE	= castle-jsp
JSP_VERSION	= 1.0.2

SVN_DIR  = /home/castle_svn/
SVN_PACKAGE_DIR = /home/castle_svn/packages

JSP1_SOURCES := img/ log/ style.css Readme.txt Makefile CastleLib.java  CastlePolicy.java  CastleReferee.java castlejsp.zip \
			index.htm index.html default.htm

JSP2_SOURCES := castle.js castle_admin.jsp castle_admin_account.jsp castle_admin_account_submit.jsp \
			castle_admin_backup.jsp castle_admin_bottom.jsp castle_admin_config.jsp \
			castle_admin_config_submit.jsp castle_admin_download.jsp castle_admin_log.jsp \
			castle_admin_log_submit.jsp castle_admin_login.jsp castle_admin_login_submit.jsp \
			castle_admin_logout_submit.jsp castle_admin_menu.jsp castle_admin_policy_ip.jsp  \
			castle_admin_policy_sql.jsp castle_admin_policy_submit.jsp castle_admin_policy_tag.jsp \
			castle_admin_policy_view.jsp castle_admin_policy_word.jsp castle_admin_policy_xss.jsp \
			castle_admin_title.jsp castle_admin_top.jsp castle_check_auth.jsp \
			castle_check_install.jsp castle_referee.jsp castle_version.jsp \
			install.jsp install_step1.jsp install_step2.jsp install_step2_submit.jsp

all: class

package: version_castlejsp package_castlejsp 

package_castlejsp: class
	@echo -n "* Packaging CASTLE JSP Version ...                      "
	@zip -q -r castlejsp.zip *.class
	@rm -rf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)
	@mkdir $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)
	@cp -rf $(JSP1_SOURCES) $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)/
	@cp -rf $(JSP2_SOURCES) $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)/
	@rm -rf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)/.svn
	@rm -rf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)/img/.svn/
	@rm -rf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)/img/*.tmp
	@rm -rf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)/log/.svn/
	@rm -rf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)/log/*.txt
	@tar -C $(SVN_PACKAGE_DIR) -zcf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)-$(JSP_VERSION).tar.gz $(JSP_PACKAGE)/ --overwrite
	@tar -C $(SVN_PACKAGE_DIR) -jcf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)-$(JSP_VERSION).tar.bz2 $(JSP_PACKAGE)/ --overwrite
	@rm -rf $(JSP_PACKAGE)-$(JSP_VERSION).zip
	@(cd $(SVN_PACKAGE_DIR); zip -q -r $(JSP_PACKAGE)-$(JSP_VERSION).zip $(JSP_PACKAGE))
	@rm -rf $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)
	@svn add $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)-$(JSP_VERSION).zip --quiet 2> /dev/null
	@svn add $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)-$(JSP_VERSION).tar.gz --quiet 2> /dev/null
	@svn add $(SVN_PACKAGE_DIR)/$(JSP_PACKAGE)-$(JSP_VERSION).tar.bz2 --quiet 2> /dev/null
	@echo "[[1;36mDone[0;37m]"

version_castlejsp:
	@echo -n "* Creating CASTLE JSP Version ...                       "
	@echo "<%" > castle_version.jsp
	@echo "String CASTLE_VERSION = \"$(JSP_VERSION)\";" >> castle_version.jsp
	@echo "%>" >> castle_version.jsp
	@echo "[[1;36mDone[0;37m]"

class:
	@echo -n "* Compiling CASTLE JSP Version ...                      "
	@javac CastleLib.java CastlePolicy.java CastleReferee.java
	@echo "[[1;36mDone[0;37m]"

clean:
	@echo -n "* Cleaning CASTLE JSP Version ...                       "
	@rm -f *.class
	@echo "[[1;36mDone[0;37m]"
