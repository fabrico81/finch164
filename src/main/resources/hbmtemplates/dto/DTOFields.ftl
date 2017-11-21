<#-- // Fields -->

<#foreach field in pojo.getDecoratedObject().getTable().getColumnIterator()>
    <#if pojo.getMetaAttribAsBool(field, "gen-property", true)> 
       <#if pojo.hasMetaAttribute(field, "field-description")>    /**
     ${pojo.getFieldJavaDoc(field, 0)}
 
     */
 </#if>    ${pojo.getFieldModifiers(field)} ${pojo.getJavaTypeName(field, jdk5)} ${field.name}<#if pojo.hasFieldInitializor(field, jdk5)> = ${pojo.getFieldInitialization(field, jdk5)}</#if>;
</#if>

  <#if field.value.isSimpleValue()> 
  <#if field.value.referencedEntityName?has_content> 
   ${field.value}
  </#if>
 </#if>

 
</#foreach>
<#foreach pippo in pojo.getDecoratedObject().getTable().getColumnIterator()>
${pippo}
</#foreach>