/**
 * 
 */
package com.testmyapplication.finch.persistence.reversestrategy;

import org.hibernate.cfg.reveng.DefaultReverseEngineeringStrategy;
import org.hibernate.cfg.reveng.DelegatingReverseEngineeringStrategy;
import org.hibernate.cfg.reveng.TableIdentifier;

import java.sql.Types;
import java.util.Properties;

/**
 * @author faber
 * 
 */
public class TableIdentifierGenerationStrategy extends DelegatingReverseEngineeringStrategy {

	public TableIdentifierGenerationStrategy() {
		super(new DefaultReverseEngineeringStrategy());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.hibernate.cfg.reveng.DefaultReverseEngineeringStrategy#
	 * getTableIdentifierStrategyName(org.hibernate.cfg.reveng.TableIdentifier)
	 */
	@Override
	public String getTableIdentifierStrategyName(TableIdentifier identifier) {

		return "sequence-identity";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.hibernate.cfg.reveng.DelegatingReverseEngineeringStrategy#
	 * getTableIdentifierProperties(org.hibernate.cfg.reveng.TableIdentifier)
	 */
	@Override
	public Properties getTableIdentifierProperties(TableIdentifier identifier) {
		Properties pr = new Properties();
		pr.put("sequence", identifier.getName().toUpperCase().concat("_ID_SEQ"));
		return pr;

	}

	@Override
	public String columnToHibernateTypeName(TableIdentifier table, String columnName, int sqlType, int length, int precision, int scale,
			boolean nullable, boolean generatedIdentifier) {

		if (((sqlType == Types.DECIMAL) || (sqlType == Types.NUMERIC)) && (scale <= 0)) {

			if (precision == 1) {
				return Boolean.class.getName();
			}
			if (precision < 3) {
				return Byte.class.getName();
			}
			if (precision < 5) {
				return Short.class.getName();
			}
			if (precision < 10) {
				return Integer.class.getName();
			}
			if (precision < 19) {
				return Long.class.getName();
			}

			return "big_decimal";
		} else if (sqlType == Types.DATE || sqlType == Types.TIMESTAMP) {
			return java.util.Date.class.getName();
		} else if (sqlType == Types.CLOB /*|| sqlType == Types.NCLOB*/) {
			return String.class.getName();
		} else {
			return super.columnToHibernateTypeName(table, columnName, sqlType, length, precision, scale, nullable, generatedIdentifier);
		}

	}

	/*

	 @Override
	 public Map tableToMetaAttributes(final TableIdentifier tableIdentifier) {
	     Map<String, MetaAttribute> metaAttributes =
	             super.tableToMetaAttributes(tableIdentifier);
	     if (metaAttributes == null) {
	         metaAttributes = new HashMap<String, MetaAttribute>();
	     }

	     String tableName = tableIdentifier.getName();
	     if (isToCache(tableName)){
	         MetaAttribute attribute = new MetaAttribute("extends");
	         attribute.addValue("it.telecom.vmc.webapp.server.persistence.cache.impl.EHCacheEnabledDAO");
	         metaAttributes.put("extends", attribute);
	     } else {
	    	 MetaAttribute attribute = new MetaAttribute("extends");
	         attribute.addValue("it.telecom.vmc.webapp.server.persistence.cache.impl.EHCacheDisabledDAO");
	         metaAttributes.put("extends", attribute);


	     }
	     return metaAttributes;
	 }

	 */


	@Override
	public boolean excludeTable(TableIdentifier ti) {

		return ti.getName().equalsIgnoreCase("USER");


	}
}

