package com.koreait.www.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@EnableTransactionManagement
@MapperScan(basePackages = { "com.koreait.www.repository" })
@Configuration
public class RootConfig {

	@Autowired
	ApplicationContext applicationContext;

	@Bean
	public DataSource dataSource() {

		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikariConfig.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/springdb");
		hikariConfig.setUsername("springuser");
		hikariConfig.setPassword("mysql");

		hikariConfig.setMaximumPoolSize(5);
		hikariConfig.setMinimumIdle(5);

		hikariConfig.setConnectionTestQuery("SELECT now()");
		hikariConfig.setPoolName("springHikariCP");

		hikariConfig.addDataSourceProperty("dataSource.cachePrepStmts", "true");

		hikariConfig.addDataSourceProperty("dataSource.prepStmtsCacheSize", "250");

		hikariConfig.addDataSourceProperty("dataSource.prepStmtsCacheSqlLimit", "true");

		hikariConfig.addDataSourceProperty("dataSource.useServerprepStmts", "true");

		HikariDataSource hikariDataSource = new HikariDataSource(hikariConfig);
		return hikariDataSource;

	}

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlFactoryBean = new SqlSessionFactoryBean();
		sqlFactoryBean.setDataSource(dataSource());
		sqlFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/mapper/*.xml"));

		sqlFactoryBean.setConfigLocation(applicationContext.getResource("classpath:/mybatisConfig.xml"));

		return sqlFactoryBean.getObject();
	}

	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}

}
