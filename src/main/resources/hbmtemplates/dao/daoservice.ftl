${pojo.getPackageDeclaration()}
<#macro toUnderScore camelCase>
${camelCase?replace("[A-Z]", "_$0", 'r')?upper_case}</#macro>
<#include "cacheableTableList.ftl"/>

// Generated ${date} by Hibernate Tools ${version}

<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>/**
 * Home object for domain model class ${declarationName}.
 * @see ${entityPackage}.${declarationName}
 * @author vasmoncat Team
 */

@${pojo.importType("javax.ejb.TransactionAttribute")}(TransactionAttributeType.SUPPORTS)
@${pojo.importType("javax.ejb.Stateless")}(name="testmyapplication/finch/dao/${pojo.getDeclarationName()}DAO")
//@${pojo.importType("javax.ejb.Local")}(I${pojo.getDeclarationName()}DAO.class)
public class ${pojo.getDeclarationName()}DAO implements I${pojo.getDeclarationName()}DAO{

    private static final ${pojo.importType("org.apache.commons.logging.Log")} log = ${pojo.importType("org.apache.commons.logging.LogFactory")}.getLog(${pojo.getDeclarationName()}DAO.class);
   
 
    @${pojo.importType("javax.persistence.PersistenceContext")}(name = "${persistenceUnit}", unitName = "${persistenceUnit}") 
	protected ${pojo.importType("javax.persistence.EntityManager")} entityManager;
 
    /**
     * save an ${declarationName} to the database
     * 
     * @param transientInstance the ${declarationName} to save
     */
	@Override 
    public void persist(${entityPackage}.${declarationName} transientInstance) {
        log.debug("persisting ${declarationName} instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        }
        catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }
 
    /**
     * delete an ${declarationName} from the database
     * 
     * @param persistentInstance the ${declarationName} to delete
     */
	@Override 
    public void remove(${entityPackage}.${declarationName} persistentInstance) {
        log.debug("removing ${declarationName} instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        }
        catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }
    
    /**
     * merge an ${declarationName}. This can be either a INSERT or UPDATE in the database
     * 
     * @param detachedInstance the ${declarationName} to merge
     * 
     * @return the merged ${declarationName}
     */
	@Override
    public ${entityPackage}.${declarationName} merge(${entityPackage}.${declarationName} detachedInstance) {
        log.debug("merging ${declarationName} instance");
        try {
            ${entityPackage}.${declarationName} result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        }
        catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }
	
	 /**
     * Load all the ${pojo.getDeclarationName()}s
     *
     * @return the list of all ${pojo.getDeclarationName()}s
     */
	@Override 
	public List<${entityPackage}.${declarationName}> findAll(){
		return findByCriteria();
	}
	
    
<#if clazz.identifierProperty?has_content>    

    /**
     * Find an ${declarationName} by its primary key object ${pojo.getJavaTypeName(clazz.identifierProperty, jdk5)}
     *
     * @param id the primary key ${pojo.getJavaTypeName(clazz.identifierProperty, jdk5)} object
     * @return the ${declarationName}
     */
	@Override
    public ${entityPackage}.${declarationName} findById( ${pojo.getJavaTypeName(clazz.identifierProperty, jdk5)} id) {
        log.debug("getting ${declarationName} instance with id: " + id);
        try {
            ${entityPackage}.${declarationName} instance = entityManager.find(${entityPackage}.${declarationName}.class, id);
            log.debug("get successful");
            return instance;
        }
        catch (RuntimeException re) {
            log.error("get instance with id failed", re);
            throw re;
        }
    }
</#if>

    /**
     * Find ${declarationName}s based on an example
     *
     * @param exampleInstance the example
     * @return the list of ${pojo.getDeclarationName()}s
     */
    @Override 
	public List<${entityPackage}.${declarationName}> findByExample(final ${entityPackage}.${declarationName} exampleInstance){
	    log.debug("finding ${declarationName} instance by example: " + exampleInstance);
        try {
 
     		Session session = (Session) entityManager.getDelegate();
     		Example example = Example.create(exampleInstance).excludeZeroes(); 
     		Criteria crit = session.createCriteria(${entityPackage}.${declarationName}.class).add(example);
     		<#list seq as x><#if x = "${declarationName}">     		crit.setCacheRegion( ICacheInjector.VASMONCAT_QUERY_LONG_TIME_NAME);  </#if></#list>  
		    final List<${entityPackage}.${declarationName}> result = crit.list();  
		    log.debug("get successful");
		    return result; 	
	      }
        catch (RuntimeException re) {
            log.error("get instance by example failed", re);
            throw re;
        }
  }
    /**
     * Find ${declarationName}s based on an example using static metamodel
     *
     * @param exampleInstance the example
     * @return the list of ${pojo.getDeclarationName()}s
     */
     
     @Override
  	 public List<${entityPackage}.${declarationName}> findByExampleMetaModel(final ${entityPackage}.${declarationName} exampleInstance) { 
	       try {
       
		        CriteriaBuilder cb = entityManager.getCriteriaBuilder(); 
		        CriteriaQuery<${entityPackage}.${declarationName}> cq = cb.createQuery(${entityPackage}.${declarationName}.class); 
		        Root<${entityPackage}.${declarationName}> r = cq.from(${entityPackage}.${declarationName}.class); 
		        Predicate p = cb.conjunction(); 
		        Metamodel mm = entityManager.getMetamodel(); 
		        EntityType<${entityPackage}.${declarationName}> et = mm.entity(${entityPackage}.${declarationName}.class); 
		        Set<Attribute<? super ${entityPackage}.${declarationName}, ?>> attrs = et.getAttributes(); 
    			LinkedHashMap<String, Object> parameters = new LinkedHashMap<String, Object>();
		        for (Attribute<? super ${entityPackage}.${declarationName}, ?> a: attrs) { 
		            String name = a.getName(); 
		            String javaName = a.getJavaMember().getName(); 
		            Method m = ${entityPackage}.${declarationName}.class.getMethod(javaName, (Class<?>[]) null); 
		            
		            if(!m.isAnnotationPresent(javax.persistence.OneToMany.class)){
		               if (m.invoke(exampleInstance, (Object[]) null) !=  null){ 
		            	   ParameterExpression<?> parameter = cb.parameter(a.getJavaType(), a.getName());
		                   p = cb.and(p, cb.equal(r.get(name), parameter));
                           parameters.put(name, m.invoke(exampleInstance, (Object[]) null));
		               }
		            }
		        } 
		        cq.select(r).where(p); 
		        
		        TypedQuery<${entityPackage}.${declarationName}> query = entityManager.createQuery(cq); 

     			Iterator<String> iter = parameters.keySet().iterator();
	    		String key;
		    	while (iter.hasNext()) {
			    	key = iter.next();
				    query.setParameter(key, parameters.get(key));
			    }
<#list seq as x><#if x = "${declarationName}">EhCacheHelper.hintInCache(query, ICacheInjector.VASMONCAT_QUERY_LONG_TIME_NAME); </#if> </#list>  
 			    return query.getResultList(); 

	    }catch (Exception e) {
            log.error("get instance by findByExampleMetaModel failed", e);
            throw new RuntimeException(e);
        }

	    } 
  

	/**
     * Find ${declarationName}s based on an a property
     *
     * @param propertyName the name of the property
	 * @param value the value of the property
     * @return the list of ${pojo.getDeclarationName()}s
     */
    @Override 
    @SuppressWarnings("unchecked") 
	public List<${entityPackage}.${declarationName}> findByProperty(String propertyName, Object value){
	    log.debug("finding ${declarationName} instance with property: " + propertyName + ", value: " + value);
        try {
        
            String queryString = "from ${declarationName} as model where model." + propertyName + "= ?";
		    Session session = (Session) entityManager.getDelegate();
            ${pojo.importType("org.hibernate.Query")} queryObject = session.createQuery(queryString);
		    queryObject.setParameter(0, value);
<#list seq as x><#if x = "${declarationName}">		    queryObject.setCacheRegion( ICacheInjector.VASMONCAT_QUERY_LONG_TIME_NAME ); </#if></#list>  
		    return queryObject.list();
	    
	    }catch (RuntimeException re) {
            log.error("get instance by property failed", re);
            throw re;
        }

	
	}

	/**
     * Find ${declarationName}s based on an a attribute
     *
     * @param attribute the attribute to search
	 * @param value the value of the attribute
     * @return the list of ${declarationName}s
     */
    @Override 
	public List<${entityPackage}.${declarationName}> findByAttribute(final SingularAttribute<${entityPackage}.${declarationName},?> attribute, Object value){
	    log.debug("finding Account instance with Metamodel singluarAttribute: " + attribute + ", value: " + value);
        try {
        
	        CriteriaBuilder cb = entityManager.getCriteriaBuilder(); 
	        CriteriaQuery<${entityPackage}.${declarationName}> cq = cb.createQuery(${entityPackage}.${declarationName}.class); 
	        Root<${entityPackage}.${declarationName}> r = cq.from(${entityPackage}.${declarationName}.class); 
	        ParameterExpression<?> parameter = cb.parameter(attribute.getJavaType(), attribute.getName());
	        Predicate condition = cb.equal(r.get(attribute),parameter);
	        cq.where(condition);
	        TypedQuery<${entityPackage}.${declarationName}> typedQuery = entityManager.createQuery(cq);
	        typedQuery.setParameter(attribute.getName(), value);
<#list seq as x><#if x = "${declarationName}">	        EhCacheHelper.hintInCache(typedQuery, ICacheInjector.VASMONCAT_QUERY_LONG_TIME_NAME); </#if></#list>  
	        List<${entityPackage}.${declarationName}> result = typedQuery.getResultList();
	        return result;
	    
	    }catch (RuntimeException re) {
            log.error("get instance by attribute failed", re);
            throw re;
        }

	
	}


	/**
     * Construct a CriteriaQuery<${declarationName}Response> for flat Response constructor
     *
     * @return criteria the CriteriaQuery<${declarationName}Response>
     */

    protected <T extends ${declarationName}Response> CriteriaQuery<T> getResponseCriteriaQuery(Class<T> returnType){
        log.debug("CriteriaQuery building for ${responsePackage}.${declarationName}Response");
        try {
            CriteriaBuilder builder = entityManager.getCriteriaBuilder(); 
		    CriteriaQuery<T> criteria = builder.createQuery( returnType );
		    Root<${entityPackage}.${declarationName}> root = criteria.from( ${entityPackage}.${declarationName}.class );
		    criteria.select(
		       builder.construct(
		            returnType,
     	        <#list pojo.getAllPropertiesIterator() as field >
		            <#if pojo.getMetaAttribAsBool(field, "gen-property", true)> 
		               <#if field.getValue().isSimpleValue()>
		                   <#if c2j.isComponent(field)>		             
		                       <#list c2j.getPOJOClass(field.getValue()).getAllPropertiesIterator() as compfield >
		                          <#if compfield_index != 0>,</#if>root.get(${entityPackage}.${declarationName}_.${field.name}).get(${entityPackage}.${c2j.getPOJOClass(field.getValue()).importType(c2j.getPOJOClass(field.getValue()).getDeclarationName())?replace("\\$", "")}_.${compfield.name})
		                       </#list>
		                    <#elseif c2h.isManyToOne(field) || c2h.isOneToOne(field)>
		                     <#if field_index != 0>,</#if>root.get(${entityPackage}.${declarationName}_.${field.name}).get(${entityPackage}.${pojo.getJavaTypeName(field, true)}_.id)
		                    <#else> 
		                     <#if field_index != 0>,</#if>root.get(${entityPackage}.${declarationName}_.${field.name})   
		                    </#if>  
		            </#if>
                  </#if>
	          </#list>
		       )
            );
            
            return criteria;
	    }catch (RuntimeException re) {
            log.error("getResponseCriteriaQuery failed", re);
            throw re;
        }
    
    }
    
    /**
     * Construct a CriteriaQuery<${declarationName}Response> for flat Response constructor
     *
     * @return criteria the CriteriaQuery<${declarationName}Response>
     */

    protected CriteriaQuery<${declarationName}Response> getResponseCriteriaQuery(){
        return getResponseCriteriaQuery(${declarationName}Response.class);    
    }
    
	/**
     * Gets the Root<${entityPackage}.${declarationName}>, if any, in the passed 
     * CriteriaQuery<${responsePackage}.${declarationName}Response> criteriaQuery 
     *
     * @param criteriaQuery the CriteriaQuery<${responsePackage}.${declarationName}Response>
     * @return root the Root<${entityPackage}.${declarationName}> of the CriteriaQuery<${responsePackage}.${declarationName}Response>
     */
    @SuppressWarnings("unchecked")
	protected Root<${entityPackage}.${declarationName}> getRoot(
			CriteriaQuery<? extends ${declarationName}Response> criteriaQuery) {
		Root<${entityPackage}.${declarationName}> root = null;
		try {
			if (!criteriaQuery.getRoots().isEmpty()) {
				Iterator<Root<?>> iter = criteriaQuery.getRoots().iterator();
				while (iter.hasNext()) {
					Root<?> genericsRoot = iter.next();
					if (genericsRoot.getModel().getName().equals("${declarationName}")) {
						root = (Root<${entityPackage}.${declarationName}>) genericsRoot;
					}
				}
				if (root != null) {
					return root;
				} else {
					throw new RuntimeException("Root<${entityPackage}.${declarationName}> not found in the passed CriteriaQuery");
				}
			} else {
				throw new RuntimeException("the passed CriteriaQuery has no Root<?>");
			}
		} catch (RuntimeException re) {
			log.error("getRoot<${entityPackage}.${declarationName}> failed", re);
			throw re;
		}
	}
	

	/**
	 * Use this inside subclasses as a convenience method.
	 */
	public List<${entityPackage}.${declarationName}> findByCriteria(Criterion... criterion) {
		return findByCriteria(-1, -1, criterion);
	}
	
	public List<${entityPackage}.${declarationName}> findBySimpleExpression(SimpleExpression... simpleExpression){
		return findByCriteria(-1, -1, (Criterion[])simpleExpression);
	}
	/**
	 * Use this inside subclasses as a convenience method.
	 */
	@SuppressWarnings("unchecked")
	public List<${entityPackage}.${declarationName}> findByCriteria(int firstResult,
			 int maxResults, Criterion... criterion) {
		Session session = (Session) entityManager.getDelegate();
		Criteria crit = session.createCriteria(${entityPackage}.${declarationName}.class);
<#list seq as x><#if x = "${declarationName}">		crit.setCacheRegion( ICacheInjector.VASMONCAT_QUERY_LONG_TIME_NAME);  </#if></#list>  
		for (final Criterion c : criterion) {
			crit.add(c);
		}

		if (firstResult > 0) {
			crit.setFirstResult(firstResult);
		}

		if (maxResults > 0) {
			crit.setMaxResults(maxResults);
		}

		final List<${entityPackage}.${declarationName}> result = crit.list();
		return result;
	}	
	
	public <T extends ${declarationName}Response>List<T> getList${declarationName}(Class<T> returnType,${declarationName}Response exampleInstance,String[] sortBy, String... rowStartIdxAndCount){
		final String method = "getList${declarationName}(Class<T> returnType, ${declarationName}Response exampleInstance, String[] sortBy, String... rowStartIdxAndCount)";
		log.debug(method);

		try {
			LinkedHashMap<String, Object> parameters = new LinkedHashMap<String, Object>();
			
			CriteriaBuilder cb = entityManager.getCriteriaBuilder();
		    CriteriaQuery<T> cq = cb.createQuery( returnType );
		    Root<${entityPackage}.${declarationName}> root = cq.from(${entityPackage}.${declarationName}.class);
		    
		    cq.select(getCompoundSelection(returnType,cb,root));

			if (exampleInstance != null) {
				LinkedHashMap<String, Object> fieldsMap = convertExampleInstanceToMap(exampleInstance);
				LinkedHashMap<String, Predicate> predicatesMap = getPredicates(cb, root);
				Predicate predicate = parsePredicates(cb, predicatesMap, fieldsMap);
				parameters = parseParameters(fieldsMap, predicatesMap);

				cq.where(predicate);
			} 

			cq.orderBy(getOrders(sortBy, cb, root));
			
			TypedQuery<T> query = entityManager.createQuery(cq);
			setParametersQuery(parameters, query,rowStartIdxAndCount);					
<#list seq as x><#if x = "${declarationName}">			EhCacheHelper.hintInCache(query, ICacheInjector.VASMONCAT_QUERY_LONG_TIME_NAME);</#if></#list> 
			return (List<T>) query.getResultList();

		} catch (RuntimeException re) {
			log.error(method, re);
			throw re;
		}
	}
	
	public <T extends ${declarationName}Response> CompoundSelection<T> getCompoundSelection(Class<T> returnType,CriteriaBuilder cb, Root<${entityPackage}.${declarationName}> root){
		return cb.construct(
	            returnType,
        			<#list pojo.getAllPropertiesIterator() as field >
			            <#if pojo.getMetaAttribAsBool(field, "gen-property", true)> 
			               <#if field.getValue().isSimpleValue()>
			                   <#if c2j.isComponent(field)>		             
			                       <#list c2j.getPOJOClass(field.getValue()).getAllPropertiesIterator() as compfield >
			                          <#if compfield_index != 0>,</#if>root.get(${entityPackage}.${declarationName}_.${field.name}).get(${entityPackage}.${c2j.getPOJOClass(field.getValue()).importType(c2j.getPOJOClass(field.getValue()).getDeclarationName())?replace("\\$", "")}_.${compfield.name})
			                       </#list>
			                    <#elseif c2h.isManyToOne(field) || c2h.isOneToOne(field)>
			                     <#if field_index != 0>,</#if>root.get(${entityPackage}.${declarationName}_.${field.name}).get(${entityPackage}.${pojo.getJavaTypeName(field, true)}_.id)
			                    <#else> 
			                     <#if field_index != 0>,</#if>root.get(${entityPackage}.${declarationName}_.${field.name})   
			                    </#if>  
			            </#if>
	                  </#if>
		          </#list>
        );
	}	

	protected LinkedHashMap<String, Predicate> getPredicates(CriteriaBuilder cb, Root<${entityPackage}.${declarationName}> root) {
		LinkedHashMap<String, Predicate> predicates = new LinkedHashMap<String, Predicate>();

		<#list pojo.getAllPropertiesIterator() as field >
            <#if pojo.getMetaAttribAsBool(field, "gen-property", true)> 
               <#if field.getValue().isSimpleValue()>                             		 
                    <#if c2h.isManyToOne(field) || c2h.isOneToOne(field)>
		predicates.put(${declarationName}Response.ID_<@toUnderScore camelCase=field.name/>, cb.equal(root.get(${declarationName}_.${field.name}).get(${entityPackage}.${pojo.getJavaTypeName(field, true)}_.id), cb.parameter(BigDecimal.class, ${declarationName}Response.ID_<@toUnderScore camelCase=field.name/>)));
			<#else> 
				<#if pojo.getJavaTypeName(field, true)=="String">
           			 <#assign expr1="cb.like(cb.upper(root.get("+ declarationName + "_." + field.name + "))">
           		<#else>
           			 <#assign expr1="cb.equal(root.get(" + declarationName + "_." + field.name + ")">
       			</#if>	 
		predicates.put(${declarationName}Response.<@toUnderScore camelCase=field.name/>, ${expr1}, cb.parameter(${pojo.getJavaTypeName(field, true)}.class, ${declarationName}Response.<@toUnderScore camelCase=field.name/>)));  
                    </#if>  
	            </#if>
            </#if>
       </#list>
		return predicates;
	}
		
	protected List<Order> getOrders(String[] sortBy, CriteriaBuilder cb, Root<${entityPackage}.${declarationName}> root) {
		List<Order> orders = new ArrayList<Order>();

		if (sortBy != null && sortBy.length > 0) {
			for (String sorting : sortBy) {
				boolean asc = true;
				if (sorting.charAt(0) == '-') {
					asc = false;
					sorting = sorting.substring(1);
				}
								
<#list pojo.getAllPropertiesIterator() as field >
    <#if pojo.getMetaAttribAsBool(field, "gen-property", true)> 
       <#if field.getValue().isSimpleValue()>
            <#if c2h.isManyToOne(field) || c2h.isOneToOne(field)>
		        if (sorting.equals(${declarationName}Response.ID_<@toUnderScore camelCase=field.name/>)) {            
        			orders = JPAUtil.addAndGetOrderBy(cb, orders, asc, root.get(${entityPackage}.${declarationName}_.${field.name}).get(${entityPackage}.${pojo.getJavaTypeName(field, true)}_.id));
                }
            <#else> 
		        if (sorting.equals(${declarationName}Response.<@toUnderScore camelCase=field.name/>)) {             
					orders = JPAUtil.addAndGetOrderBy(cb, orders, asc, root.get(${entityPackage}.${declarationName}_.${field.name}));
				}
            </#if>  
   	   </#if>
    </#if>
</#list>
			}
		}
		
		return orders;
	}
	
	protected LinkedHashMap<String, Object> convertExampleInstanceToMap(${declarationName}Response exampleInstance){
		LinkedHashMap<String, Object> items = new LinkedHashMap<String, Object>();
		<#list pojo.getAllPropertiesIterator() as field >
		            <#if pojo.getMetaAttribAsBool(field, "gen-property", true)> 
		               <#if field.getValue().isSimpleValue()>
		                    <#if c2h.isManyToOne(field) || c2h.isOneToOne(field)>
        items.put(${declarationName}Response.ID_<@toUnderScore camelCase=field.name/>,exampleInstance.getId${field.name?cap_first}());
		                    <#else> 
		items.put(${declarationName}Response.<@toUnderScore camelCase=field.name/>,exampleInstance.get${field.name?cap_first}());   
		                    </#if>  
		            </#if>
                  </#if>
	       </#list>
	       
		return items;
	}    
	
	protected final Predicate parsePredicates( CriteriaBuilder cb, LinkedHashMap<String, Predicate> predicates,LinkedHashMap<String, Object> fieldsMap) {
		Predicate predicate = cb.conjunction();
		
		Iterator<String> iter = fieldsMap.keySet().iterator();
		String key;
		while (iter.hasNext()) {
			key = iter.next();
			if (fieldsMap.get(key) != null) {
				Predicate predicateTmp = predicates.get(key);
				predicate = cb.and(predicate, predicateTmp);
			}
		}
		
		return predicate;
	}
	
	protected final LinkedHashMap<String, Object> parseParameters(LinkedHashMap<String, Object> fieldsMap, LinkedHashMap<String, Predicate> predicatesMap) {
		LinkedHashMap<String, Object> parameters = new LinkedHashMap<String, Object>();

		Iterator<String> iter = fieldsMap.keySet().iterator();
		String key;
		while (iter.hasNext()) {
			key = iter.next();
			if (fieldsMap.get(key) != null) {
				if (fieldsMap.get(key) instanceof String) {
					Predicate predicateTmp = predicatesMap.get(key);
					String value = (String) fieldsMap.get(key);
					if (predicateTmp instanceof LikePredicate) {
						value = "%" + value.toUpperCase() + "%";
					}
					parameters.put(key, value);
				} else {
					parameters.put(key, fieldsMap.get(key));
				}
			}
		}
		
		return parameters;
	}
	
	protected final TypedQuery<?> setParametersQuery(LinkedHashMap<String, Object> parameters,TypedQuery<?> query,String... rowStartIdxAndCount) {
		if (parameters.size() > 0) {
			Iterator<String> iter = parameters.keySet().iterator();
			String key;
			while (iter.hasNext()) {
				key = iter.next();
				query.setParameter(key, parameters.get(key));
			}
		}				
		JPAUtil.setPagination(query, rowStartIdxAndCount);
		
		return query;
	}
	
}	

</#assign>
${pojo.generateImports()}

import java.lang.reflect.Method;

import java.util.Iterator;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.ArrayList;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.SimpleExpression;
import org.hibernate.ejb.criteria.predicate.LikePredicate;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CompoundSelection;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Order;
import javax.persistence.criteria.ParameterExpression;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.Attribute;
import javax.persistence.metamodel.EntityType;
import javax.persistence.metamodel.Metamodel;
import javax.persistence.metamodel.SingularAttribute;

import javax.ejb.TransactionAttributeType;


import it.telecom.vmc.webapp.server.persistence.util.JPAUtil;
<#list seq as x>
<#if x = "${declarationName}">  	
import it.telecom.vmc.webapp.server.persistence.cache.impl.EhCacheHelper;
import it.telecom.vmc.webapp.server.persistence.cache.service.ICacheInjector;
</#if>
</#list>  

import ${entityPackage}.*;
import ${responsePackage}.${declarationName}Response;
import ${daoPackage}.I${pojo.getDeclarationName()}DAO;
${classbody}
