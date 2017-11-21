package ${daoPackage};

// Generated ${date} by Hibernate Tools ${version}

<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>/**
 * DAO Interface for domain model class {@link ${declarationName}}.
 * @see {@link ${entityPackage}.${declarationName}}
 * @author vasmoncat Team
 */
@${pojo.importType("javax.ejb.Local")}
@${pojo.importType("org.jboss.ejb3.annotation.LocalBinding")}(jndiBinding = "vasmoncat/webapp/dao/${pojo.getDeclarationName()}DAO/local")
public interface I${pojo.getDeclarationName()}DAO{

    /**
     * save an {@link ${declarationName}} to the database
     * 
     * @param transientInstance the ${declarationName} to save
     */
	public void persist(${entityPackage}.${declarationName} transientInstance); 

    /**
     * delete an {@link ${declarationName}} from the database
     * 
     * @param persistentInstance the ${declarationName} to delete
     */
	public void remove(${entityPackage}.${declarationName} persistentInstance);

    /**
     * save an ${declarationName}. This can be either a INSERT or UPDATE in the database
     * 
     * @param detachedInstance the ${declarationName} to save
     * 
     * @return the saved ${declarationName}
     */
	public ${entityPackage}.${declarationName} merge(${entityPackage}.${declarationName} detachedInstance);

	 /**
     * Load all the ${pojo.getDeclarationName()}s
     *
     * @return the list of all ${pojo.getDeclarationName()}s
     */
	public List<${entityPackage}.${declarationName}> findAll();

<#if clazz.identifierProperty?has_content>    
    /**
     * Find an ${declarationName} by its primary key object ${pojo.getJavaTypeName(clazz.identifierProperty, jdk5)}
     *
     * @param id the primary key ${pojo.getJavaTypeName(clazz.identifierProperty, jdk5)} object
     * @return the ${declarationName}
     */
    public ${entityPackage}.${declarationName} findById( ${pojo.getJavaTypeName(clazz.identifierProperty, jdk5)} id);
</#if>	

    /**
     * Find ${declarationName}s based on an example
     *
     * @param exampleInstance the example
     * @return the list of ${pojo.getDeclarationName()}s
     */
	public List<${entityPackage}.${declarationName}> findByExample(final ${pojo.getDeclarationName()} exampleInstance);


    /**
     * Find ${declarationName}s based on an example using static metamodel
     *
     * @param exampleInstance the example
     * @return the list of ${pojo.getDeclarationName()}s
     */
    public List<${entityPackage}.${declarationName}> findByExampleMetaModel(final ${entityPackage}.${declarationName} exampleInstance);


    /**
     * Find ${declarationName}s based on an a property
     *
     * @param propertyName the name of the property
	 * @param value the value of the property
     * @return the list of ${pojo.getDeclarationName()}s
     */
	public List<${entityPackage}.${declarationName}> findByProperty(String propertyName, Object value);
	
    
    /**
     * Find ${declarationName}s based on an a attribute
     *
     * @param attribute the attribute to search
	 * @param value the value of the attribute
     * @return the list of ${declarationName}s
     */
	public List<${entityPackage}.${declarationName}> findByAttribute(final SingularAttribute<${entityPackage}.${declarationName},?> attribute, Object value);
	
	public List<${entityPackage}.${declarationName}> findByCriteria(Criterion... criterion);
	
	public List<${entityPackage}.${declarationName}> findBySimpleExpression(SimpleExpression... simpleExpression);
	
	public List<${entityPackage}.${declarationName}> findByCriteria(int firstResult,  int maxResults, Criterion... criterion);
	
	public <T extends ${declarationName}Response>List<T> getList${declarationName}(Class<T> returnType, ${declarationName}Response exampleInstance, String[] sortBy, String... rowStartIdxAndCount) throws Exception;
}

</#assign>
${pojo.generateImports()}
import java.util.List;

import javax.persistence.metamodel.SingularAttribute;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.SimpleExpression;

import ${entityPackage}.*;
import ${responsePackage}.${declarationName}Response;

${classbody}